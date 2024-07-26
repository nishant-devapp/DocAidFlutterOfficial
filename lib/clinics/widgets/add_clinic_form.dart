import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/widgets/AppButton.dart';
import 'package:flutter/material.dart';

import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';

class AddClinicForm extends StatefulWidget {
  const AddClinicForm({super.key});

  @override
  State<AddClinicForm> createState() => _AddClinicFormState();
}

class _AddClinicFormState extends State<AddClinicForm> {

  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicAddressController = TextEditingController();
  final TextEditingController _clinicInchargeNameController = TextEditingController();
  final TextEditingController _clinicMobileNumberController = TextEditingController();
  final TextEditingController _clinicNewPatientFeeController = TextEditingController();
  final TextEditingController _clinicOldPatientFeeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        final doctorProfile = homeProvider.doctorProfile!;
        return Padding(
          padding: const EdgeInsets.all(15.0),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Select Start Time',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Select End Time',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
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
                  SizedBox(
                      width: double.infinity,
                      child: AppButton(buttonColor: AppColors.verdigris, buttonPressedColor: AppColors.ultraViolet, buttonText: "Submit", onPressed: _addNewClinic)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addNewClinic() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

}
