import 'package:code/accounts/provider/account_provider.dart';
import 'package:code/accounts/service/account_service.dart';
import 'package:code/home/provider/home_provider.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/constants/razorpay_keys.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ReviewSubscriptionScreen extends StatefulWidget {
  const ReviewSubscriptionScreen({super.key});

  @override
  State<ReviewSubscriptionScreen> createState() => _ReviewSubscriptionScreenState();
}

class _ReviewSubscriptionScreenState extends State<ReviewSubscriptionScreen> {
  static const platform = MethodChannel("razorpay_flutter");

  Razorpay _razorpay = Razorpay();
  AccountService _accountService = AccountService();
  String? endDate, oneDayAdded, paymentOrderId, docName, docContact, docEmail, paymentId, paymentStatus;
  int? docId, duration, totalAmountToBePaid;


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
    return  DoctorProfileBase(
        builder: (HomeGetProvider homeProvider){
          final doctorProfile = homeProvider.doctorProfile!;
          docId = doctorProfile.data!.id!;
          docName = doctorProfile.data!.firstName! + doctorProfile.data!.lastName!;
          docContact = doctorProfile.data!.contact!;
          docEmail = doctorProfile.data!.email!;
          final totalClinics = doctorProfile.data!.clinicDtos!.length;
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  const Text(
                      'Review Subscription'
                  ),
                  ElevatedButton(
                      onPressed: (){
                        // _openPaymentOptionBottomSheet(totalClinics);
                    _fetchSubscriptionAmount(3, totalClinics);
                  }, child: const Text('Pay now', style: TextStyle(fontSize: 16.0, color: AppColors.textColor),)),
                ],
              ),
            ),
          );
        }
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

            final result = await _accountService.updateCurrentSubscriptionDetails(
              paymentOrderId!,
              paymentId!,
              oneDayAdded!,
              3,
              1,
              docId!,
            );
            if (result) {
              final isHistoryCreated = await _accountService.createPaymentHistory(
                  paymentOrderId!,
                  paymentId!,
                  oneDayAdded!,
                  3,
                  1,
                  docId!);

              if(isHistoryCreated){
                showToast(context, 'Payment Successful', AppColors.verdigris, Colors.white);
              }

            } else {
              showToast(context, 'Payment Failed', AppColors.vermilion, Colors.white);
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
    print(response.error);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }


  String _addOneDay(String endDate) {
    DateTime date = DateTime.parse(endDate);
    DateTime newDate = date.add(Duration(days: 1));
    return DateFormat('yyyy-MM-dd').format(newDate);
  }

  Future<void> _fetchEndDate(int id) async {
    try {
      final endDateModel = await _accountService.getEndDate(id);
      setState(() {
        endDate = endDateModel.data;
        if (endDate != null) {
          oneDayAdded = _addOneDay(endDate!);
          print(endDate);
          print(oneDayAdded);
        }
      });
    } catch (error) {
      print('Error fetching End Date: $error');
    }
  }

  Future<void> _fetchSubscriptionAmount(int duration, int totalClinics) async {
    try {
      final subscriptionModel = await _accountService.getTotalAmount(duration, totalClinics);
      setState(() {
        totalAmountToBePaid = subscriptionModel.data;
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
      // final orderModel = await _accountService.getPaymentOrderId(totalAmountToBePaid);
      final orderModel = await _accountService.getPaymentOrderId(100);
      setState(() {
        paymentOrderId = orderModel.id;
      });

      var options = {
        'key': RazorpayKeys.productionKey,
        'amount': 100, // Convert to paise.
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

  void _openPaymentOptionBottomSheet(int totalClinics) {
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
            child: const Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Text('Monthly', style: TextStyle(),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}



