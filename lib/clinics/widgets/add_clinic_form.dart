import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:code/utils/helpers/time_picker.dart';
import 'package:code/utils/widgets/AppButton.dart';
import 'package:flutter/material.dart';

import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import 'days_selector.dart';

class AddClinicForm extends StatefulWidget {
  const AddClinicForm({super.key});

  @override
  State<AddClinicForm> createState() => _AddClinicFormState();
}

class _AddClinicFormState extends State<AddClinicForm> {
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicAddressController =
      TextEditingController();
  final TextEditingController _clinicInchargeNameController =
      TextEditingController();
  final TextEditingController _clinicMobileNumberController =
      TextEditingController();
  final TextEditingController _clinicNewPatientFeeController =
      TextEditingController();
  final TextEditingController _clinicOldPatientFeeController =
      TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<String> _selectedDays = [];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;


    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        final doctorProfile = homeProvider.doctorProfile!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Clinic Details',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _clinicNameController,
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
                    controller: _clinicAddressController,
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
                    controller: _clinicInchargeNameController,
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
                    controller: _clinicMobileNumberController,
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
                          controller: _startTimeController,
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
                          controller: _endTimeController,
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
                          controller: _clinicNewPatientFeeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                          controller: _clinicOldPatientFeeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: const Text('New Patient Fee'),
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
                  DaysSelector(onSelectionChanged: _onDaysChanged),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, deviceHeight * 0.06),
                          backgroundColor: AppColors.verdigris,
                        ),
                        onPressed: () async {
                          print(_selectedDays);
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          if (_selectedDays.isEmpty) {
                            showToast(context, 'Please select dates !',
                                AppColors.vermilion, Colors.white);
                            return;
                          }

                          await homeProvider.addClinic(
                              _clinicNameController.text,
                              _clinicAddressController.text,
                              _clinicInchargeNameController.text,
                              _startTimeController.text,
                              _endTimeController.text,
                              _clinicMobileNumberController.text,
                              _clinicNewPatientFeeController.text,
                              _clinicOldPatientFeeController.text,
                              _selectedDays);

                          Navigator.pop(context);
                        },
                        child: homeProvider.isAddingClinic
                            ? const CircularProgressIndicator()
                            : const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  void _onDaysChanged(List<String> days) {
    setState(() {
      _selectedDays = days.map((day) => day).toList();
    });
  }

  Future<void> _selectStartTime() async {
    final String selectedStartTime = await selectTime(context);
    if (selectedStartTime.isNotEmpty) {
      setState(() {
        _startTimeController.text = selectedStartTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final String selectedEndTime = await selectTime(context);
    if (selectedEndTime.isNotEmpty) {
      setState(() {
        _endTimeController.text = selectedEndTime;
      });
    }
  }

}
