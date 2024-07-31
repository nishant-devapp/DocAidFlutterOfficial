import 'package:code/appointments/widgets/unpaid_edit_payment_dialog.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointment_provider.dart';

class PaidTextDesign extends StatelessWidget {
  const PaidTextDesign({super.key, required this.appointmentId});

  final int appointmentId;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.verdigris, width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.verdigris.withOpacity(0.1),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 10.0,
                  color: AppColors.verdigris,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Paid',
                  style: TextStyle(
                      color: AppColors.verdigris,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return UnpaidEditPaymentDialog(
                appointmentId: appointmentId,
              );
            },
          );
        },
      );
    });
  }
}
