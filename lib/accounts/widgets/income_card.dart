import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
    required this.totalEarning,
    required this.upiEarning,
    required this.cashEarning,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Orange line
          Container(
            height: 15,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.princetonOrange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalEarning,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.princetonOrange,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Text(
                  upiEarning,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.princetonOrange,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "UPI",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Text(
                  cashEarning,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.princetonOrange,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Cash",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
