import 'package:code/accounts/provider/account_provider.dart';
import 'package:code/accounts/widgets/income_card.dart';
import 'package:code/accounts/widgets/single_visit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewStatsScreen extends StatefulWidget {
  const ViewStatsScreen({super.key});

  @override
  State<ViewStatsScreen> createState() => _ViewStatsScreenState();
}

class _ViewStatsScreenState extends State<ViewStatsScreen> {

  @override
  void initState() {
    super.initState();
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
    accountProvider.fetchTodayVisit();
    accountProvider.fetchThisMonthVisit();
    accountProvider.fetchTodayEarning();
    accountProvider.fetchThisMonthEarning();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child){
        if (accountProvider.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (accountProvider.errorMessage != null) {
          return Center(child: Text('Error: ${accountProvider.errorMessage}'));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SingleVisitCard(
                        count: accountProvider.todayVisit?.data ?? 0,
                        description: "Today's Visit",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SingleVisitCard(
                        count: accountProvider.thisMonthVisit?.data ?? 0,
                        description: "This Month's Visit",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Today's Income",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          IncomeCard(
                            totalEarning: accountProvider.todayEarning?.data!.totalAmount ?? 0.0,
                            upiEarning: accountProvider.todayEarning?.data!.upiAmount ?? 0.0,
                            cashEarning: accountProvider.todayEarning?.data!.cashAmount ?? 0.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "This Month's Income",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          IncomeCard(
                            totalEarning: accountProvider.thisMonthEarning?.data!.totalAmount ?? 0.0,
                            upiEarning: accountProvider.thisMonthEarning?.data!.upiAmount ?? 0.0,
                            cashEarning: accountProvider.thisMonthEarning?.data!.cashAmount ?? 0.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
