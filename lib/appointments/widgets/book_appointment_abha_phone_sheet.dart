import 'package:code/appointments/widgets/patient_selection_sheet.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../models/abha_patient_list_model.dart' as abhaPatientData;
import '../models/patient_list_by_contact_model.dart' as phonePatientData;
import '../service/patient_detail_service.dart';
import 'book_appointment_form.dart';

class BookAppointmentAbhaPhoneSheet extends StatefulWidget {
  const BookAppointmentAbhaPhoneSheet({super.key});

  @override
  State<BookAppointmentAbhaPhoneSheet> createState() =>
      _BookAppointmentAbhaPhoneSheetState();
}

class _BookAppointmentAbhaPhoneSheetState
    extends State<BookAppointmentAbhaPhoneSheet> {
  final _abhaController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PatientDetailService _patientDetailService = PatientDetailService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _abhaController,
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('ABHA Number'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (_phoneController.text.isEmpty && value!.isEmpty) {
                      return 'Please fill one field';
                    }
                    if (_phoneController.text.isNotEmpty && value!.isNotEmpty) {
                      return 'Fill only one field';
                    }
                    if (value!.isNotEmpty && value.length != 14) {
                      return 'ABHA Number must be 14 digits';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 2.0,
                              child: Container(color: AppColors.jet))),
                      const SizedBox(width: 12.0),
                      const Text('OR',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor)),
                      const SizedBox(width: 12.0),
                      Expanded(
                          child: SizedBox(
                              height: 2.0,
                              child: Container(color: AppColors.jet))),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    label: const Text('Mobile Number'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (_abhaController.text.isEmpty && value!.isEmpty) {
                      return 'Please fill one field';
                    }
                    if (_abhaController.text.isNotEmpty && value!.isNotEmpty) {
                      return 'Fill only one field';
                    }
                    if (value!.isNotEmpty && value.length != 10) {
                      return 'Phone Number must be 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _fetchAndDisplayPatientInfo();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, deviceHeight * 0.06),
                          backgroundColor: AppColors.textColor,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchAndDisplayPatientInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      abhaPatientData.AbhaPatientDetailModel? patientData;
      phonePatientData.ContactPatientDetailModel? patientDataByContact;
      abhaPatientData.Data? patientInfo;

      if (_abhaController.text.isNotEmpty) {
        patientData = await _patientDetailService
            .fetchPatientInfoByAbha(_abhaController.text.trim());
        patientInfo = patientData?.data;
        if (patientInfo != null) {
          Navigator.pop(context);
          _showPatientInfoBottomSheet(patientInfo);
        } else {
          Navigator.pop(context);
          _showPatientInfoBottomSheet(
            abhaPatientData.Data(
              abhaNumber:
              _abhaController.text.isNotEmpty ? _abhaController.text : null,
              contact:
              _phoneController.text.isNotEmpty ? _phoneController.text : null,
            ),
          );
        }
      }

      if (_phoneController.text.isNotEmpty) {
        patientDataByContact = await _patientDetailService
            .fetchPatientInfoByContact(_phoneController.text.trim());
        if (patientDataByContact?.data != null && patientDataByContact!.data!.isNotEmpty) {
          Navigator.pop(context);
          _showPatientListByContactSheet(patientDataByContact.data!, _phoneController.text.trim());  // Pass the list to the bottom sheet
          return;
        }else{
          Navigator.pop(context);
          _showPatientInfoBottomSheet(
            abhaPatientData.Data(
              abhaNumber:
              _abhaController.text.isNotEmpty ? _abhaController.text : null,
              contact:
              _phoneController.text.isNotEmpty ? _phoneController.text : null,
            ),
          );
        }
      }


    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPatientListByContactSheet(List<phonePatientData.Data> patientList, String phone){
    showModalBottomSheet(context: context,
        isScrollControlled: true, // This makes the bottom sheet full screen
        builder: (context) => DraggableScrollableSheet(
          expand: false,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Padding(padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
                child: PatientSelectionSheet(patientList: patientList, phone: phone,),
              ),
            )),
    );
  }

  void _showPatientInfoBottomSheet(abhaPatientData.Data patientData) {
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
              patientInfo: patientData,
              abha:
                  _abhaController.text.isNotEmpty ? _abhaController.text : null,
              phone: _phoneController.text.isNotEmpty
                  ? _phoneController.text
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
