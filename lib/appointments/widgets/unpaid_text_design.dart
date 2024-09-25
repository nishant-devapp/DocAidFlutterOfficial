import 'package:code/appointments/widgets/do_payment_dialog.dart';
import 'package:code/home/models/home_get_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';

class UnpaidTextDesign extends StatelessWidget {
  const UnpaidTextDesign(
      {super.key, required this.appointmentId, required this.clinicId, required this.docId, required this.appointmentDate, required this.clinicLocation, required this.visitStatus});

  final int appointmentId, clinicId, docId;
  final String appointmentDate, clinicLocation, visitStatus;

  @override
  Widget build(BuildContext context) {

   // late var clinicNewPatientFee, clinicOldPatientFee;

    return Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
      final clinics = homeProvider.getClinics();

      final clinic = clinics.firstWhere(
            (clinic) => clinic.location == clinicLocation, // Default values if not found
      );

      final clinicNewPatientFee = clinic.clinicNewFees!.toInt().toString();
      final clinicOldPatientFee = clinic.clinicOldFees!.toInt().toString();

      return InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DoPaymentDialog(
                appointmentId: appointmentId,
                clinicId: clinicId,
                docId: docId,
                appointmentDate: appointmentDate,
                clinicNewFee: clinicNewPatientFee,
                clinicOldFee: clinicOldPatientFee,
                visitStatus: visitStatus,
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.vermilion, width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.vermilion.withOpacity(0.1),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 10.0,
                  color: AppColors.vermilion,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Unpaid',
                  style: TextStyle(
                      color: AppColors.vermilion,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
