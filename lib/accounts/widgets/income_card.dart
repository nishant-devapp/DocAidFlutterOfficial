import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard(
      {super.key,
      required this.totalEarning,
      required this.upiEarning,
      required this.cashEarning});

  final String totalEarning;
  final String upiEarning;
  final String cashEarning;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: AppColors.princetonOrange.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              decoration: const BoxDecoration(
                color: AppColors.princetonOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
            Text(
              totalEarning,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.princetonOrange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Total",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),


            Text(
              upiEarning,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.princetonOrange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "UPI",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),


            Text(
              cashEarning,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.princetonOrange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Cash",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
