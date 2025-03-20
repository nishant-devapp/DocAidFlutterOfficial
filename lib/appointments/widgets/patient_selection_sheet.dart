import 'package:code/appointments/widgets/patient_selection_sheet_item.dart';
import '../../utils/constants/colors.dart';
import '../models/patient_list_by_contact_model.dart' as phonePatientData;

import 'package:flutter/material.dart';

import 'book_appointment_form.dart';

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
  int patientListLength = widget.patientList.length;
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Select Patient', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),),
              PatientSelectionSheetItem(patientList: widget.patientList, phone: widget.phone,),
              const SizedBox(height: 20.0,),

              if(patientListLength < 6)
                ElevatedButton.icon(
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
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
                            patientInfo: null,
                            abha: null,
                            phone: widget.phone
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 22.0, color: Colors.white,),
                // iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, screenHeight * 0.06),
                  backgroundColor: AppColors.princetonOrange,
                  // padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                label: const Text(
                  'Add New Patient',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
