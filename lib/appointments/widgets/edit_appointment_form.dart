import 'package:code/appointments/models/fetch_appointment_model.dart' as appointment_model;
import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';

class EditAppointmentForm extends StatefulWidget {
  const EditAppointmentForm({super.key, this.appointment});

  final appointment_model.AppointmentData? appointment;

  @override
  State<EditAppointmentForm> createState() => _EditAppointmentFormState();
}

class _EditAppointmentFormState extends State<EditAppointmentForm> {

  final _key = GlobalKey<FormState>();
  String? _selectedGender;
  final List<String> _genders = ['Select Gender', 'MALE', 'FEMALE'];
  DateTime? _selectedDate;
  ClinicDtos? _selectedClinic;
  List<ClinicDtos> _filteredClinics = [];
  List<ClinicDtos> _allClinics = [];
  List<String> _timeSlots = [];
  int? _selectedClinicId;
  bool _isUpdating = false;
  String? _selectedClinicLocation, _selectedTime;

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
      _selectedGender = widget.appointment!.gender!;

      // Initialize _selectedClinic
      _selectedClinic = null;
      _fetchAndInitializeClinics();
    }

  }

  Future<void> _fetchAndInitializeClinics() async {
    final homeProvider =
    context.read<HomeGetProvider>(); // Ensure correct provider usage
    final clinics = homeProvider.getClinics();

    // Debug statement
    print('Clinics fetched: ${clinics.length}');

    setState(() {
      _allClinics = clinics;
      _filterClinicsByDate(_allClinics);
    });
  }

  @override
  void dispose() {
    _editAppointmentNameController.dispose();
    _editAgeController.dispose();
    _editContactController.dispose();
    _editAbhaController.dispose();
    _editDateController.dispose();
    super.dispose();
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
              key: _key,
              child: Column(
                children: [
                  // Text(widget.appointment!.id.toString()),
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
                    readOnly: true,
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
                    readOnly: true,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<ClinicDtos>(
                          value: _selectedClinic,
                          decoration: InputDecoration(
                            labelText: 'Select Clinic',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.all(15.0),
                          ),
                          onChanged: (ClinicDtos? newValue) {
                            setState(() {
                              _selectedClinic = newValue;
                              _generateTimeSlots();
                            });
                            if (newValue != null) {
                              _selectedClinicId = newValue.id;
                              _selectedClinicLocation = newValue.location;
                              print('Clinic ID: $_selectedClinicId');
                              print('Clinic Name: $_selectedClinicLocation');
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a clinic';
                            }
                            return null;
                          },
                          hint: const Text('Select Clinic'),
                          items: _filteredClinics.map((clinic) {
                            return DropdownMenuItem<ClinicDtos>(
                              value: clinic,
                              child: Text(clinic.location!),
                            );
                          }).toList(),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          iconSize: 24,
                          elevation: 16,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedTime,
                          decoration: InputDecoration(
                            labelText: 'Select Time',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.all(15.0),
                          ),
                          items: _timeSlots.map((time) {
                            return DropdownMenuItem<String>(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select time';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedTime = value;
                              print(_selectedTime);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isUpdating ? null : _deleteAppointment,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, deviceHeight * 0.06),
                            backgroundColor: AppColors.vermilion,
                          ),
                          child: _isUpdating
                              ? const CircularProgressIndicator()
                              : const Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isUpdating ? null : _updateAppointment,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, deviceHeight * 0.06),
                            backgroundColor: AppColors.verdigris,
                          ),
                          child: _isUpdating
                              ? const CircularProgressIndicator()
                              : const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),

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
          _filterClinicsByDate(_allClinics);
        });
      });
    }
  }

  void _filterClinicsByDate(List<ClinicDtos> clinics) {
    if (_selectedDate == null) {
      _filteredClinics = [];
      return;
    }

    // Filter clinics based on the selected date
    final filteredClinics = clinics
        .where((clinic) {
      final operatingDays = clinic.days;
      final dayOfWeek = DateFormat('EEEE').format(_selectedDate!).toUpperCase();
      return operatingDays!.contains(dayOfWeek);
    })
        .toList(); // Ensure the result is a List<ClinicDtos>

    setState(() {
      _filteredClinics = filteredClinics;
      if (_selectedClinic != null &&
          !_filteredClinics.any((clinic) => clinic.id == _selectedClinic!.id)) {
        _selectedClinic = null; // Reset selection if it's no longer valid
      }
    });
  }

  void _generateTimeSlots() {
    if (_selectedClinic == null) return;

    final startTime = _selectedClinic!.parsedStartTime;
    final endTime = _selectedClinic!.parsedEndTime;
    final timeSlots = <String>[];

    DateTime currentTime = DateTime(
        0, 1, 1, startTime.hour, startTime.minute, startTime.second
    );

    while (currentTime.isBefore(DateTime(0, 1, 1, endTime.hour, endTime.minute, endTime.second))) {
      final formattedTime = DateFormat('h:mm a').format(currentTime);
      timeSlots.add(formattedTime);
      currentTime = currentTime.add(const Duration(minutes: 5));
    }

    setState(() {
      _timeSlots = timeSlots;
      _selectedTime = null;
    });
  }

  void _deleteAppointment() async{
    if( widget.appointment!.id != null){

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: Provider.of<AppointmentProvider>(context, listen: false)
                .deleteAppointment(widget.appointment!.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Deleting Appointment...', style: TextStyle(color: AppColors.textColor, fontSize: 16.0),),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text('Error deleting appointment: ${snapshot.error}'),
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
                  content: const Text('Appointment Deleted successfully!'),
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
  }

  void _updateAppointment() async{
    if (!_key.currentState!.validate()) {
      return;
    }

    final bookingTime = DateFormat('HH:mm:ss').format(DateFormat('h:mm a').parse(_selectedTime.toString()));
    final bookingDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: Provider.of<AppointmentProvider>(context, listen: false).updateAppointmentInfo(
            widget.appointment!.id!,
            _editAppointmentNameController.text.trim(),
            widget.appointment!.abhaNumber!,
            int.parse(_editAgeController.text.trim()),
            widget.appointment!.contact!,
            _selectedGender!,
            bookingDate,
            bookingTime,
            _selectedClinicLocation!,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text('Updating...', style: TextStyle(color: AppColors.textColor, fontSize: 18.0),),
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
                content: const Text('Appointment Updated successfully!'),
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

}
