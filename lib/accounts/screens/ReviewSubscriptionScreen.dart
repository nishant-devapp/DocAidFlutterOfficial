import 'package:code/accounts/provider/account_provider.dart';
import 'package:code/accounts/service/account_service.dart';
import 'package:code/home/provider/home_provider.dart';
import 'package:code/home/screens/home_screen.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/constants/razorpay_keys.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:code/utils/helpers/docAidLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../widgets/duration_selector_bottom_sheet.dart';
import '../widgets/subscription_history_item.dart';

class ReviewSubscriptionScreen extends StatefulWidget {
  const ReviewSubscriptionScreen({super.key});

  @override
  State<ReviewSubscriptionScreen> createState() =>
      _ReviewSubscriptionScreenState();
}

class _ReviewSubscriptionScreenState extends State<ReviewSubscriptionScreen> {
  static const platform = MethodChannel("razorpay_flutter");

  final Razorpay _razorpay = Razorpay();
  final AccountService _accountService = AccountService();
  String? endDate, oneDayAdded, paymentOrderId, docName, docContact, docEmail, paymentId, paymentStatus;
  int? docId, duration, totalClinics, totalAmountToBePaid;

  @override
  void initState() {
    super.initState();

    final homeProvider = Provider.of<HomeGetProvider>(context, listen: false);

    _fetchEndDate(homeProvider.doctorProfile!.data!.id!);

    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);

    accountProvider.fetchSubscriptionHistory(homeProvider.doctorProfile!.data!.id!);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);


  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;

    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final doctorProfile = homeProvider.doctorProfile!;
      docId = doctorProfile.data!.id!;
      docName = doctorProfile.data!.firstName! + doctorProfile.data!.lastName!;
      docContact = doctorProfile.data!.contact!;
      docEmail = doctorProfile.data!.email!;
      totalClinics = doctorProfile.data!.clinicDtos!
          .where((clinic) => clinic.clinicStatus == "Active")
          .length;

      // totalClinics = doctorProfile.data!.clinicDtos!.length;

      return Consumer<AccountProvider>(
          builder: (context, accountProvider, child) {
        final history = accountProvider.subscriptionHistory;
        final isLoading = accountProvider.isFetchingSubscriptionHistory;

        return Scaffold(
          body: Column(
            children: [
              Card(
                elevation: 6.0,
                color: AppColors.celeste.withValues(alpha: 0.8),
                shadowColor: AppColors.princetonOrange.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: deviceWidth * 0.03,
                  horizontal: deviceWidth * 0.04,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose Subscription',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Monthly Subscription amount is Rs. 1500/month',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _openDurationSelectionSheet(context);
                          },
                          icon: const Icon(Icons.payment_outlined,
                              color: AppColors.darkGreenColor),
                          label: Text(
                            "Pay Now",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGreenColor.withValues(alpha: 0.6),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 2.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              if (isLoading)
                const Center(
                  child: DocAidLoader(),
                ),
              if (history == null || history.data!.isEmpty)
                const Center(
                  child: Text('No subscription history available'),
                )
              else
                Expanded(
                  child: SubscriptionHistoryItem(
                    subscriptionHistory: history,
                  ),
                ),
            ],
          ),
        );
      });
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    // print("Payment Success Response: $response");
    // print("Signature: ${response.signature}");
    // print("Order ID: ${response.orderId}");
    // print("Payment ID: ${response.paymentId}");

    paymentId = response.paymentId;

    // print("PaymentId: $paymentId");

    try {
      final verificationModel = await _accountService.getPaymentStatus(paymentId!);
      if (!mounted) return;
      setState(() {
        paymentStatus = verificationModel.status;
        print(paymentStatus);
      });
      if (paymentStatus == "captured" || paymentStatus == "authorised") {
        try{
          if (paymentOrderId != null && oneDayAdded != null && docId != null) {

            final result = await _accountService.updateCurrentSubscriptionDetails(
              paymentOrderId!,
              paymentId!,
              oneDayAdded!,
              duration!,
              totalAmountToBePaid!,
              docId!,
            );

            if (result) {
              final isHistoryCreated = await _accountService.createPaymentHistory(
                paymentOrderId!,
                paymentId!,
                oneDayAdded!,
                duration!,
                totalAmountToBePaid!,
                docId!,
              );

              if (isHistoryCreated) {
                showToast(context, 'Payment Successful', AppColors.verdigris, Colors.white);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false, // Removes all previous routes
                );
              } else {
                showToast(
                    context, 'Payment Failed', AppColors.vermilion, Colors.white);
              }
            } else {
              showToast(
                  context, 'Payment Failed', AppColors.vermilion, Colors.white);
            }
          }
          else {
            showToast(
                context, 'Payment Failed', AppColors.vermilion, Colors.white);
          }
        }catch (error) {
          print('Error updating subscription details: $error');
        }
      }
    } catch (error) {
      showToast(context, 'Payment Failed', AppColors.vermilion, Colors.white);
      print('Error handling payment success: $error');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToast(context, 'Payment Failed!', AppColors.vermilion, Colors.white);
    print('Error: ${response.error}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('External Wallet: ${response.walletName}');
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

  String _addOneDay(String endDate) {
    DateTime date = DateTime.parse(endDate);
    DateTime newDate = date.add(const Duration(days: 1));
    return DateFormat('yyyy-MM-dd').format(newDate);
  }

  Future<void> _fetchSubscriptionAmount(int duration, int totalClinics) async {
    try {
      final subscriptionModel =
          await _accountService.getTotalAmount(duration, totalClinics);
      setState(() {
        totalAmountToBePaid = subscriptionModel.data;
        print("Total amount to be paid: $totalAmountToBePaid");
      });
      if (totalAmountToBePaid != null) {
        await _fetchSubscriptionOrderId(totalAmountToBePaid!);
      }
    } catch (error) {
      print('Error fetching Subscription Amount: $error');
    }
  }
  Future<void> _fetchSubscriptionOrderId(int paymentAmount) async {

    try {
      final orderModel = await _accountService.getPaymentOrderId(paymentAmount);

      setState(() {
        paymentOrderId = orderModel.id;
      print('Payment Order Id: $paymentOrderId');
      });


      var options = {
        'key': RazorpayKeys.testKey,
        'amount': paymentAmount,
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


  void _openDurationSelectionSheet(BuildContext context) {
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
            child: DurationSelectorBottomSheet(
              onDurationSelected: (selectedDuration) {
                if (mounted) {
                  setState(() {
                    duration = selectedDuration;
                  });
                }
                // print("Total Clinics: ${totalClinics.toString()}");
                // print("Duration: $duration");

                _fetchSubscriptionAmount(duration!, totalClinics!);

              },
            ),
          ),
        ),
      ),
    );
  }
}
