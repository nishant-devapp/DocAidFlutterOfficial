import '../models/patient_list_by_contact_model.dart' as phonePatientData;
import '../models/abha_patient_list_model.dart' as abhaPatientData;
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import 'book_appointment_form.dart';

class PatientSelectionSheetItem extends StatefulWidget {
  const PatientSelectionSheetItem({super.key, required this.patientList, required this.phone});

  final List<phonePatientData.Data> patientList;
  final String phone;


  @override
  State<PatientSelectionSheetItem> createState() =>
      _PatientSelectionSheetItemState();
}

class _PatientSelectionSheetItemState extends State<PatientSelectionSheetItem> {
  int? _selectedPatientIndex; // Tracks the selected patient index

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final patients = widget.patientList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: patients.length,
          itemBuilder: (context, index) {
            final patient = patients[index];
            return Card(
              elevation: 3.0,
              shadowColor: AppColors.verdigris.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  backgroundColor: AppColors.princetonOrange,
                  child: Text(
                    patient.name?.substring(0, 1).toUpperCase() ?? '-',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  patient.name ?? 'No Name',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Age: ${patient.age ?? 'N/A'} | Gender: ${patient.gender ?? 'N/A'}',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Radio<int>(
                  value: index,
                  groupValue: _selectedPatientIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedPatientIndex = value;
                    });
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _selectedPatientIndex != null
              ? () {
            final selectedPatient = patients[_selectedPatientIndex!];
            _navigateToBookAppointment(context, selectedPatient);
          }
              : null, // Button is disabled when no patient is selected
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.verdigris,
            disabledBackgroundColor: Colors.grey,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _navigateToBookAppointment(BuildContext context, phonePatientData.Data patient) {
    final abhaPatient = convertToAbhaPatientData(patient);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This makes the bottom sheet full screen
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: BookAppointmentForm(
              patientInfo: abhaPatient,
              abha: null,
              phone: widget.phone,
            ),
          ),
        ),
      ),
    );
  }

  abhaPatientData.Data convertToAbhaPatientData(phonePatientData.Data patient) {
    return abhaPatientData.Data(
      id: patient.id,
      name: patient.name,
      age: patient.age,
      gender: patient.gender,
      abhaNumber: patient.abhaNumber,
      address: patient.address,
      contact: patient.contact,
      guardianName: patient.guardianName,
      // Add any other fields that match between the two models
    );
  }

}
