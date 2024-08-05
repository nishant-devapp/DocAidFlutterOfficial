import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/time_picker.dart';
import 'days_selector.dart';

class EditClinicForm extends StatefulWidget {
  const EditClinicForm({super.key, this.clinicToEdit});

  final ClinicDtos? clinicToEdit;

  @override
  State<EditClinicForm> createState() => _EditClinicFormState();
}

class _EditClinicFormState extends State<EditClinicForm> {
  final TextEditingController _editClinicNameController =
      TextEditingController();
  final TextEditingController _editClinicAddressController =
      TextEditingController();
  final TextEditingController _editClinicInchargeNameController =
      TextEditingController();
  final TextEditingController _editClinicMobileNumberController =
      TextEditingController();
  final TextEditingController _editClinicNewPatientFeeController =
      TextEditingController();
  final TextEditingController _editClinicOldPatientFeeController =
      TextEditingController();
  final TextEditingController _editStartTimeController =
      TextEditingController();
  final TextEditingController _editEndTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isUpdating = false;

  List<String> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    if (widget.clinicToEdit != null) {
      _editClinicNameController.text = widget.clinicToEdit!.clinicName!;
      _editClinicAddressController.text = widget.clinicToEdit!.location!;
      _editClinicInchargeNameController.text = widget.clinicToEdit!.incharge!;
      _editClinicMobileNumberController.text =
          widget.clinicToEdit!.clinicContact!;
      if (widget.clinicToEdit!.clinicNewFees != null) {
        _editClinicNewPatientFeeController.text =
            widget.clinicToEdit!.clinicNewFees!.toInt().toString();
      } else {
        _editClinicNewPatientFeeController.text = '0';
      }
      if (widget.clinicToEdit!.clinicOldFees != null) {
        _editClinicOldPatientFeeController.text =
            widget.clinicToEdit!.clinicOldFees!.toInt().toString();
      } else {
        _editClinicOldPatientFeeController.text = '0';
      }
      _editStartTimeController.text = widget.clinicToEdit!.startTime!;
      _editEndTimeController.text = widget.clinicToEdit!.endTime!;
      _selectedDays = widget.clinicToEdit!.days!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        // final doctorProfile = homeProvider.doctorProfile!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    'Edit Clinic',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _editClinicNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('Clinic Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter clinic name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _editClinicAddressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_sharp),
                        label: const Text('Address'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter clinic address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _editClinicInchargeNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text('Incharge Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter incharge name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: _editClinicMobileNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        label: const Text('Mobile Number'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _editStartTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: 'Start Time',
                            prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.access_time_outlined,
                                  color: AppColors.princetonOrange,
                                ),
                                onPressed: _selectStartTime),
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter start time';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: _editEndTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: 'End Time',
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.access_time_outlined,
                                color: AppColors.princetonOrange,
                              ),
                              // onPressed: () => _selectDate(context),
                              onPressed: _selectEndTime,
                            ),
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter end time';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _editClinicNewPatientFeeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.currency_rupee),
                              label: const Text('New Patient Fee'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter new patient fee';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: _editClinicOldPatientFeeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.currency_rupee),
                              label: const Text('Old Patient Fee'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter old patient fee';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Select Days',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w500),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DaysSelector(
                    onSelectionChanged: _onDaysChanged,
                    selectedDays: _selectedDays,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                    onPressed: _isUpdating ? null : _editClinic,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, deviceHeight * 0.06),
                      backgroundColor: AppColors.verdigris,
                    ),
                    child: _isUpdating
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _editClinic() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isUpdating = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder(
          future:
              Provider.of<HomeGetProvider>(context, listen: false).updateClinic(
            widget.clinicToEdit!.id!,
            _editClinicNameController.text.trim(),
            _editClinicAddressController.text.trim(),
            _editClinicInchargeNameController.text.trim(),
            _selectedDays,
            _editStartTimeController.text.trim(),
            _editEndTimeController.text.trim(),
            _editClinicMobileNumberController.text.trim(),
            _editClinicNewPatientFeeController.text.trim(),
            _editClinicOldPatientFeeController.text.trim(),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text(
                      'Updating...',
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 18.0),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Error updating appointment: ${snapshot.error}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            } else {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Clinic Updated successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  Future<void> _selectStartTime() async {
    final String selectedStartTime = await selectTime(context);
    if (selectedStartTime.isNotEmpty) {
      setState(() {
        _editStartTimeController.text = selectedStartTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final String selectedEndTime = await selectTime(context);
    if (selectedEndTime.isNotEmpty) {
      setState(() {
        _editEndTimeController.text = selectedEndTime;
      });
    }
  }

  void _onDaysChanged(List<String> days) {
    setState(() {
      _selectedDays = days.map((day) => day).toList();
    });
  }
}
