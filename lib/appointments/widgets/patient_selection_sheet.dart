import 'package:code/appointments/widgets/patient_selection_sheet_item.dart';
import 'package:flutter/material.dart';

class PatientSelectionSheet extends StatefulWidget {
  const PatientSelectionSheet({super.key});

  @override
  State<PatientSelectionSheet> createState() => _PatientSelectionSheetState();
}

class _PatientSelectionSheetState extends State<PatientSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Select Patient', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),),
        // PatientSelectionSheetItem(patientList: patientList)
      ],
    );
  }
}
