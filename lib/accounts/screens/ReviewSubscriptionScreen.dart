import 'package:flutter/material.dart';

class ReviewSubscriptionScreen extends StatefulWidget {
  const ReviewSubscriptionScreen({super.key});

  @override
  State<ReviewSubscriptionScreen> createState() => _ReviewSubscriptionScreenState();
}

class _ReviewSubscriptionScreenState extends State<ReviewSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Review Subscription'
        ),
      ),
    );
  }
}
