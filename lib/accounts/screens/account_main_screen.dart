import 'package:code/accounts/screens/ReviewSubscriptionScreen.dart';
import 'package:code/accounts/screens/ViewStatsScreen.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AccountMainScreen extends StatefulWidget {
  const AccountMainScreen({super.key});

  @override
  State<AccountMainScreen> createState() => _AccountMainScreenState();
}

class _AccountMainScreenState extends State<AccountMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 30.0),
              SizedBox(
                height: 55,
                // Removed background color and indicator
                child: TabBar(
                  controller: _tabController,
                  // Set indicator to null to remove the underline
                  indicator: null,
                  labelColor: AppColors.textColor,
                  unselectedLabelColor: AppColors.textColor.withOpacity(0.3),
                  isScrollable: false, // Ensure tabs take full width
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: const Center(
                                child: Text(
                                  'View Stats',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: const Center(
                                child: Text(
                                  'Review Subscription',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    ViewStatsScreen(),
                    ReviewSubscriptionScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
