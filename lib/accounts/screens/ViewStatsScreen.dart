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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(height: 8.0,),
              SingleVisitCard(count: '1',description: "Today's Visit",),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 8.0,),
              SingleVisitCard(count: '5', description: "This Month's Visit"),

            ],
          ),
        ],
      ),
    );
  }
}
