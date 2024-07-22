import 'package:code/accounts/widgets/income_card.dart';
import 'package:code/accounts/widgets/single_visit_card.dart';
import 'package:flutter/material.dart';

class ViewStatsScreen extends StatefulWidget {
  const ViewStatsScreen({super.key});

  @override
  State<ViewStatsScreen> createState() => _ViewStatsScreenState();
}

class _ViewStatsScreenState extends State<ViewStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SingleVisitCard(
                    count: '1',
                    description: "Today's Visit",
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: SingleVisitCard(
                    count: '5',
                    description: "This Month's Visit",
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
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
                      SizedBox(height: 8.0),
                      IncomeCard(
                        totalEarning: "Rs. 0.0",
                        upiEarning: "Rs. 0.0",
                        cashEarning: "Rs. 1000.0",
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
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
                      SizedBox(height: 8.0),
                      IncomeCard(
                        totalEarning: "Rs. 1950.0",
                        upiEarning: "Rs. 750.0",
                        cashEarning: "Rs. 1200.0",
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
}
