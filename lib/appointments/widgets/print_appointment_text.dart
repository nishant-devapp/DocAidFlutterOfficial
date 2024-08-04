import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PrintAppointmentText extends StatelessWidget {
  PrintAppointmentText({super.key, required this.title, required this.text});

  String title, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: AppColors.textColor),),
          const SizedBox(height: 5.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(text, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColors.textColor),),
          ),
        ],
      ),
    );
  }
}

