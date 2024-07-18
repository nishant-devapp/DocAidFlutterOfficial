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
            Row(
              children: [
                Expanded(child: SingleVisitCard(count: '1',description: "Today's Visit",)),
                SizedBox(height: 16.0,),
                Expanded(child: SingleVisitCard(count: '5', description: "This Month's Visit")),
        
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Today's Income"),
                    IncomeCard(totalEarning: "Rs. 0.0", upiEarning: "Rs. 0.0", cashEarning: "Rs. 10.0"),
                    // SizedBox(height: 8.0,),
                    SizedBox(height: 20.0,),
                    Text("Today's Income"),
                    IncomeCard(totalEarning: "Rs. 1950.0", upiEarning: "Rs. 750.0", cashEarning: "Rs. 1200.0")

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
