import 'package:code/clinics/services/clinic_service.dart';
import 'package:code/clinics/widgets/add_clinic_form.dart';
import 'package:code/clinics/widgets/clinic_charge_dialog.dart';
import 'package:code/clinics/widgets/clinic_item.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../accounts/provider/account_provider.dart';
import '../../accounts/service/account_service.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../../utils/constants/razorpay_keys.dart';
import '../../utils/helpers/Toaster.dart';

class ClinicScreen extends StatefulWidget {
  const ClinicScreen({super.key});

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {


  static const platform = MethodChannel("razorpay_flutter");

  Razorpay _razorpay = Razorpay();
  AccountService _accountService = AccountService();
  ClinicService _clinicService = ClinicService();
  String? endDate, oneDayAdded, paymentOrderId, docName, docContact, docEmail, paymentId, paymentStatus;
  int? docId, duration, totalAmountToBePaid, daysDifference;

  @override
  void initState() {
    super.initState();

    final homeProvider = Provider.of<HomeGetProvider>(context, listen: false);
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);

    _fetchEndDate(homeProvider.doctorProfile!.data!.id!);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      body: DoctorProfileBase(
        builder: (HomeGetProvider homeProvider) {
          final doctorProfile = homeProvider.doctorProfile!;
          docId = doctorProfile.data!.id!;
          docName = doctorProfile.data!.firstName! + doctorProfile.data!.lastName!;
          docContact = doctorProfile.data!.contact!;
          docEmail = doctorProfile.data!.email!;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ClinicChargeDialog(
                                title: "Additional Clinic Charges",
                                description: "",
                                onAccept: () {
                                  Navigator.of(context).pop();
                                  calculateAdditionalClinicCharge(daysDifference!);
                                  // _openAddClinicBottomSheet(context);
                                },
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add,
                            size: 35.0, color: AppColors.textColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Expanded(child: ClinicItem()),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.signature);
    print(response.orderId);
    print(response.paymentId);

    paymentId = response.paymentId;

    try {
      final verificationModel = await _accountService.getPaymentStatus(paymentId!);
      setState(() {
        paymentStatus = verificationModel.status;
      });

      if (paymentStatus == "captured" || paymentStatus == "authorised") {
        try {
          if (paymentOrderId != null && oneDayAdded != null && docId != null) {

              final isHistoryCreated = await _accountService.createPaymentHistory(
                  paymentOrderId!,
                  paymentId!,
                  oneDayAdded!,
                  3,
                  totalAmountToBePaid!,
                  docId!);

              if(isHistoryCreated){
                showToast(context, 'Payment Successful', AppColors.verdigris, Colors.white);
                _openAddClinicBottomSheet(context);
              }


          } else {
            print('Error: Required data is missing');
          }
        } catch (error) {
          print('Error updating subscription details: $error');
        }
      }
    } catch (error) {
      print('Error fetching payment status: $error');
    }

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showToast(context, 'Payment Failed!', AppColors.vermilion, Colors.white);
    print(response.error);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> _fetchEndDate(int id) async {
    try {
      final endDateModel = await _accountService.getEndDate(id);
      setState(() {
        endDate = endDateModel.data;
        if (endDate != null) {
          oneDayAdded = _addOneDay(endDate!);
          daysDifference = _calculateDaysDifference(endDate!);
          print(endDate);
          print(oneDayAdded);
          print(daysDifference);
        }
      });
    } catch (error) {
      print('Error Fetching End Date: $error');
    }
  }

  String _addOneDay(String endDate) {
    DateTime date = DateTime.parse(endDate);
    DateTime newDate = date.add(const Duration(days: 1));
    return DateFormat('yyyy-MM-dd').format(newDate);
  }

  int _calculateDaysDifference(String endDate) {
    // Future date
    String futureDateStr = endDate;
    DateTime futureDate = DateTime.parse(futureDateStr);

    // Today's date
    DateTime today = DateTime.now();

    // Calculate the difference
    Duration difference = futureDate.difference(today);

     return difference.inDays;

  }

  void _openAddClinicBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This makes the bottom sheet full screen
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddClinicForm(),
          ),
        ),
      ),
    );
  }

  Future<void> calculateAdditionalClinicCharge(int remainingDays) async {
    try {
      final calculateAmountModel = await _clinicService.calculateAdditionalClinicAmount(remainingDays);
      setState(() {
        totalAmountToBePaid = calculateAmountModel.data;
        print(totalAmountToBePaid);
      });
      if (totalAmountToBePaid != null) {
        await _fetchSubscriptionOrderId(totalAmountToBePaid!);
      }
    } catch (error) {
      print('Error fetching Subscription Amount: $error');
    }
  }

  Future<void> _fetchSubscriptionOrderId(int totalAmountToBePaid) async {
    try {
      final orderModel = await _accountService.getPaymentOrderId(totalAmountToBePaid);
      setState(() {
        paymentOrderId = orderModel.id;
      });

      var options = {
        'key': RazorpayKeys.testKey,
        'amount': totalAmountToBePaid,
        'name': 'Doc-Aid',
        'order_id': paymentOrderId, // Generate order_id using Orders API
        'currency': "INR",
        'description': "Payment",
        'image': "https://d2sv8898xch8nu.cloudfront.net/MediaFiles/doc-aid.png",
        'timeout': 180, // in seconds
        "prefill": {
          'name': docName,
          "email": docEmail,
          "contact": docContact,
        },
        "theme": {
          "color": "#F37254",
        },
      };

      _razorpay.open(options);
    } catch (error) {
      print('Error fetching OrderID: $error');
    }
  }


}
