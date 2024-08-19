import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ActiveSubscriptionText extends StatelessWidget {
  const ActiveSubscriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:3.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.darkGreenColor.withOpacity(0.2),
      ),
      child: const Text('Active', style: TextStyle(color: AppColors.darkGreenColor, fontSize: 16.0, fontWeight: FontWeight.w500),),
    );
  }
}
