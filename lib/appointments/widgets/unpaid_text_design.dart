import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class UnpaidTextDesign extends StatelessWidget {
  const UnpaidTextDesign({super.key, required this.appointmentId});

  final int appointmentId;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.vermilion, width: 1),
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.vermilion.withOpacity(0.1),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child: Row(
          children: [
            Icon(Icons.circle_outlined, size: 10.0,color: AppColors.vermilion,),
            SizedBox(width: 5.0,),
            Text('Unpaid', style: TextStyle(color: AppColors.vermilion, fontSize: 14.0, fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
