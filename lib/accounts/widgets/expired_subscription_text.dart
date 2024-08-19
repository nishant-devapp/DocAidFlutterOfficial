import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ExpiredSubscriptionText extends StatelessWidget {
  const ExpiredSubscriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:3.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.vermilion.withOpacity(0.2),
      ),
      child: const Text('Expired', style: TextStyle(color: AppColors.vermilion, fontSize: 16.0, fontWeight: FontWeight.w500),),
    );
  }
}
