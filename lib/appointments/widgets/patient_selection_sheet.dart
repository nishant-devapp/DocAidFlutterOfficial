import 'package:code/appointments/widgets/patient_selection_sheet_item.dart';
import '../models/patient_list_by_contact_model.dart' as phonePatientData;

import 'package:flutter/material.dart';

class PatientSelectionSheet extends StatefulWidget {
  const PatientSelectionSheet({super.key, required this.patientList, required this.phone});

  final List<phonePatientData.Data> patientList;
  final String phone;

  @override
  State<PatientSelectionSheet> createState() => _PatientSelectionSheetState();
}

class _PatientSelectionSheetState extends State<PatientSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    print(widget.patientList.length.toString());
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Select Patient', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),),
              PatientSelectionSheetItem(patientList: widget.patientList, phone: widget.phone,)
            ],
          ),
        ),
      ),
    );
  }
}
