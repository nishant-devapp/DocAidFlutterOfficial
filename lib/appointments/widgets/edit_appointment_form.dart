import 'package:code/appointments/models/fetch_appointment_model.dart' as appointment_model;
import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../home/models/home_get_model.dart';

class EditAppointmentForm extends StatefulWidget {
  const EditAppointmentForm({super.key, this.appointment});

  final appointment_model.Data? appointment;

  @override
  State<EditAppointmentForm> createState() => _EditAppointmentFormState();
}

class _EditAppointmentFormState extends State<EditAppointmentForm> {

  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedGender;
  ClinicDtos? _selectedClinic;
  List<ClinicDtos> _filteredClinics = [];
  List<ClinicDtos> _allClinics = [];
  List<String> _timeSlots = [];
  final List<String> _genders = ['Select Gender', 'MALE', 'FEMALE'];

  final TextEditingController _editAppointmentNameController = TextEditingController();
  final TextEditingController _editAbhaController = TextEditingController();
  final TextEditingController _editAgeController = TextEditingController();
  final TextEditingController _editContactController = TextEditingController();
  final TextEditingController _editDateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.appointment != null){
      _editAppointmentNameController.text = widget.appointment!.name!;
      _editAbhaController.text = widget.appointment!.abhaNumber!;
      _editAgeController.text = widget.appointment!.age.toString();
      _editContactController.text = widget.appointment!.contact!;
      _editDateController.text = widget.appointment!.appointmentDate!;
      _selectedGender = widget.appointment!.gender!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;


    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child){
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(widget.appointment!.id.toString()),
                  const Text('Edit Appointment', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.textColor),),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _editAppointmentNameController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('Full Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: _editAbhaController,
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                    decoration: InputDecoration(
                        label: const Text('ABHA'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _editAgeController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: const Text('Age'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _editContactController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
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
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          items: _genders.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                              print(_selectedGender);
                            });
                          },
                          validator: (value) {
                            if (_selectedGender == 'Select Gender') {
                              return 'Please select gender';
                            }
                            return null;
                          },
                          hint: const Text('Select Gender'),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: _editDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: 'Select Date',
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.verdigris,
                              ),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                          validator: (value) {
                            if (_selectedDate == null) {
                              return 'Please select date';
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),

                ],
              ),
            ),
          );
        }
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 100);
    final DateTime lastDate = DateTime(now.year + 100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _editDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // _filterClinicsByDate(_allClinics);
        });
      });
    }
  }
}
