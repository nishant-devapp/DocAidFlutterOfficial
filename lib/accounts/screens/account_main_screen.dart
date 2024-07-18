import 'package:code/accounts/screens/ReviewSubscriptionScreen.dart';
import 'package:code/accounts/screens/ViewStatsScreen.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountMainScreen extends StatefulWidget {
  const AccountMainScreen({super.key});

  @override
  State<AccountMainScreen> createState() => _AccountMainScreenState();
}

class _AccountMainScreenState extends State<AccountMainScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              const SizedBox(
                height: 20.0,
              ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Welcome to your account',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: AppColors.magnolia.withOpacity(1.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    // controller: tabController,
                    isScrollable: true,
                    // labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    tabs: const [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          child: Text(
                            'View Stats',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 16.0),
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          child: Text(
                            'Review Subscription',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                // controller: tabController,
                children: [
                  ViewStatsScreen(),
                  ReviewSubscriptionScreen(),
                ],
              )),
            ]),
          ),
        ),
      ),
    );
  }
}
