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
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    final deviceHeight = mediaQuery.size.height;

    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child){
        if (accountProvider.isFetchingVisit || accountProvider.isFetchingEarning) {
          return const Center(child: CircularProgressIndicator());
        }
        // if (accountProvider.errorMessage != null) {
        //   return Center(child: Text('Error: ${accountProvider.errorMessage}'));
        // }
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.02,
                vertical: deviceHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: deviceHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SingleVisitCard(
                          count: accountProvider.todayVisit?.data ?? 0,
                          description: "Today's Visit",
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.02),
                      Expanded(
                        child: SingleVisitCard(
                          count: accountProvider.thisMonthVisit?.data ?? 0,
                          description: "This Month's Visit",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(deviceWidth * 0.02),
                              child: const Text(
                                textAlign: TextAlign.center,
                                "Today's Income",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: deviceHeight * 0.01),
                            IncomeCard(
                              totalEarning: accountProvider.todayEarning?.data!.totalAmount ?? 0.0,
                              upiEarning: accountProvider.todayEarning?.data!.upiAmount ?? 0.0,
                              cashEarning: accountProvider.todayEarning?.data!.cashAmount ?? 0.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Padding(
                             padding: EdgeInsets.all(deviceWidth * 0.02),
                              child: const Text(
                                textAlign: TextAlign.center,
                                "This Month's Income",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: deviceHeight * 0.01),
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
          ),
        );
      }
    );
  }
}
