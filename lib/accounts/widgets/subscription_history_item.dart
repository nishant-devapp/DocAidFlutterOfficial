import 'package:code/accounts/model/subscription_history_model.dart';
import 'package:code/accounts/widgets/expired_subscription_text.dart';
import 'package:code/accounts/widgets/print_subscription_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../service/account_service.dart';
import 'active_subscription_text.dart';

class SubscriptionHistoryItem extends StatefulWidget {
  const SubscriptionHistoryItem({super.key, required this.subscriptionHistory});

  final SubscriptionHistoryModel? subscriptionHistory;

  @override
  State<SubscriptionHistoryItem> createState() =>
      _SubscriptionHistoryItemState();
}

class _SubscriptionHistoryItemState extends State<SubscriptionHistoryItem> {
  String? endDate, subscriptionStatus;
  AccountService _accountService = AccountService();

  @override
  void initState() {
    super.initState();

    final homeProvider = Provider.of<HomeGetProvider>(context, listen: false);
    _fetchEndDate(homeProvider.doctorProfile!.data!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;

    final subscriptions = widget.subscriptionHistory?.data ?? [];

    if(subscriptions.isEmpty ){
      return const Center(child: Text('No Subscription History'),);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final allSubscriptions = subscriptions[index];
          return Card(
            elevation: 6.0,
            shadowColor: AppColors.verdigris.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(
              vertical: deviceWidth * 0.03,
              horizontal: deviceWidth * 0.04,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubscriptionDetails(allSubscriptions),
                  const SizedBox(height: 8.0,),
                  const Divider(thickness: 1.0),
                  _buildSubscriptionActions(context, allSubscriptions),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionDetails(subscription) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subscription Period',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: AppColors.verdigris,
          ),
        ),
        const SizedBox(height:8.0),
        Text(
          '${subscription.subscriptionStartDate!}  -  ${subscription.subscriptionEndDate!}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: AppColors.jet,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Amount Paid:  \u20B9 ${subscription.amount}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionActions(BuildContext context, subscription) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        subscriptionStatus == 'Active'
            ? const ActiveSubscriptionText()
            : subscriptionStatus == 'Expired'
            ? const ExpiredSubscriptionText()
            : const Text(''),

        const SizedBox(width: 12.0),
        ElevatedButton.icon(
          onPressed: () {
            /*showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => DraggableScrollableSheet(
                expand: false,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: PrintSubscriptionSheet(subscription: subscription),
                  ),
                ),
              ),
            );*/
            showModalBottomSheet(
              context: context,
              isScrollControlled: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: PrintSubscriptionSheet(subscription: subscription),
                );
              },
            );
          },
          icon: const Icon(Icons.receipt_long, color: AppColors.vermilion),
          label: Text(
            "View Invoice",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.vermilion.withOpacity(0.8),
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 2.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _fetchEndDate(int id) async {
    try {
      final endDateModel = await _accountService.getEndDate(id);
      setState(() {
        endDate = endDateModel.data;
        if (endDate != null) {
          // Convert the fetched endDate to DateTime
          final DateTime fetchedEndDate = DateTime.parse(endDate!);

          // Get the current date
          final DateTime currentDate = DateTime.now();

          // Compare the dates
          if (fetchedEndDate.isBefore(currentDate)) {
            subscriptionStatus = "Expired";
          } else {
            subscriptionStatus = "Active";
          }
        }
      });
    } catch (error) {
      print('Error fetching End Date: $error');
    }
  }
}
