import 'package:code/appointments/models/patient_list_by_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';

class PatientSelectionSheetItem extends StatefulWidget {
  const PatientSelectionSheetItem({super.key, required this.patientList});

  final ContactPatientDetailModel? patientList;

  @override
  State<PatientSelectionSheetItem> createState() =>
      _PatientSelectionSheetItemState();
}

class _PatientSelectionSheetItemState extends State<PatientSelectionSheetItem> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final patients = widget.patientList?.data ?? [];
    final totalPatients = patients.length;
    final clinics = context.read<HomeGetProvider>().getClinics();
    int? docId = context.read<HomeGetProvider>().getDoctorId();

    return ListView.builder(
      shrinkWrap: true,
      // Set to true only if you have constraints on list height
      physics: const ClampingScrollPhysics(),
      // Use for more controlled scroll behavior
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return GestureDetector(
          onTap: (){},
          child: Card(
            elevation: 4.0,
            shadowColor: AppColors.verdigris.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.symmetric(
              vertical: screenWidth * 0.05,
              horizontal: screenWidth * 0.03,
            ),
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
