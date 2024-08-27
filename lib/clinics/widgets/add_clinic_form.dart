import 'dart:io';

import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:code/utils/helpers/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  File? _selectedPrescriptionImage;
  int? addedClinicId;

  void _onDaysChanged(List<String> days) {
    setState(() {
      _selectedDays = days.map((day) => day).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    // Adjust padding and spacing based on device width
    final double horizontalPadding = deviceWidth * 0.05;
    final double verticalSpacing = deviceHeight * 0.02;
    final double buttonHeight = deviceHeight * 0.07;

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
                  SizedBox(height: verticalSpacing * 2),
                  const Text(
                    'Clinic Details',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                InkWell(
                  onTap: _pickAndCropImage,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: 100.0,
                      child: _selectedPrescriptionImage != null
                          ? Image.file(
                        _selectedPrescriptionImage!,
                        fit: BoxFit.cover,
                      ) : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_search, color: AppColors.verdigris, size: 30.0,),
                          SizedBox(width: 10.0,),
                          Center(child: Text("Select prescription image", style: TextStyle(fontSize: 14.0, color: AppColors.textColor, fontWeight: FontWeight.w500),))
                        ],
                      ),
                    ),
                  ),
                ),
                  const SizedBox(
                    height: 15.0,
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
                              label: const Text(
                                'New Patient Fee',
                              ),
                              prefixIcon: const Icon(Icons.currency_rupee),
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
                    selectedDays: [],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, deviceHeight * 0.06),
                          backgroundColor: AppColors.verdigris,
                        ),
                        onPressed: () async {
                          // print(_selectedDays);
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          if (_selectedDays.isEmpty) {
                            showToast(context, 'Please select dates !',
                                AppColors.vermilion, Colors.white);
                            return;
                          }

                          /*print("Clinic Name ${_clinicNameController.text.trim()}");
                          print("Clinic Address ${_clinicAddressController.text.trim()}");
                          print("Clinic Incharge ${_clinicInchargeNameController.text.trim()}");
                          print("Start Time ${_startTimeController.text.trim()}");
                          print("End Time ${_endTimeController.text.trim()}");
                          print("Mobile ${_clinicMobileNumberController.text.trim()}");
                          print("New Fees ${_clinicNewPatientFeeController.text.trim()}");
                          print("Old Fees ${_clinicOldPatientFeeController.text.trim()}");
                          print(_selectedDays);
                          print(_selectedPrescriptionImage);*/

                          addedClinicId = await homeProvider.addClinic(
                              _clinicNameController.text.trim(),
                              _clinicAddressController.text.trim(),
                              _clinicInchargeNameController.text.trim(),
                              _startTimeController.text.trim(),
                              _endTimeController.text.trim(),
                              _clinicMobileNumberController.text.trim(),
                              _clinicNewPatientFeeController.text.trim(),
                              _clinicOldPatientFeeController.text.trim(),
                              _selectedDays);

                          if(addedClinicId != null && _selectedPrescriptionImage != null){
                            await Future.delayed(const Duration(milliseconds: 1500));
                            await Provider.of<HomeGetProvider>(context,
                                listen: false)
                                .uploadPrescriptionImage(
                                _selectedPrescriptionImage!, addedClinicId!);
                          }else{
                            showToast(context, 'New Clinic Added!', AppColors.verdigris, Colors.white);
                          }

                          Navigator.pop(context);
                        },
                        child: homeProvider.isAddingClinic
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickAndCropImage() async {
    try {
      // Pick an image from the gallery
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 32, ratioY: 9),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.verdigris.withOpacity(0.8),
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          ],
        );

        if (croppedFile != null) {
          // Convert CroppedFile to File
          File imageFile = File(croppedFile.path);

          setState(() {
            _selectedPrescriptionImage = imageFile;
          });
        }
      }
    } catch (e) {
      print("Image picking/cropping failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selection failed!')),
      );
    }
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
