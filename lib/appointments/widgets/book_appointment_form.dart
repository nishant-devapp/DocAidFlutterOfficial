import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/home/models/home_get_model.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../models/patient_list_by_contact_model.dart' as patient_model;
import '../models/abha_patient_list_model.dart' as abhaPatientData;


class BookAppointmentForm extends StatefulWidget {
  const BookAppointmentForm(
      {super.key, this.patientInfo, this.abha, this.phone});

  final abhaPatientData.Data? patientInfo;
  final String? abha;
  final String? phone;

  @override
  State<BookAppointmentForm> createState() => _BookAppointmentFormState();
}

class _BookAppointmentFormState extends State<BookAppointmentForm> {
  late TextEditingController _nameController,
      _abhaController,
      _ageController,
      _phoneController,
      _addressController,
      _guardianNameController,
      _dateController;
  final _key = GlobalKey<FormState>();
  String? _selectedGender;
  final List<String> _genders = ['Select Gender', 'MALE', 'FEMALE'];
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  ClinicDtos? _selectedClinic;
  List<ClinicDtos> _filteredClinics = [];
  List<ClinicDtos> _allClinics = [];
  List<String> _timeSlots = [];
  int? _selectedClinicId, doctorId;
  bool _isBooking = false;
  bool _isAddingPatient = false;
  String? _selectedClinicLocation, _selectedTime;
  Map<String, int>? _clinicAppointmentCounts;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with patient data if available
    _nameController =
        TextEditingController(text: widget.patientInfo?.name ?? '');
    _abhaController =
        TextEditingController(text: widget.patientInfo?.abhaNumber ?? '');
    _ageController = TextEditingController(text: widget.patientInfo?.age?.toString() ?? '');
    _addressController = TextEditingController(text: widget.patientInfo?.address ?? '');
    _guardianNameController = TextEditingController(text: widget.patientInfo?.guardianName ?? '');
    _phoneController = TextEditingController(text: widget.phone ?? '');
    _dateController = TextEditingController();
    _selectedGender = widget.patientInfo?.gender ?? 'Select Gender';

    // Initialize _selectedClinic
    _selectedClinic = null;
    _fetchAndInitializeClinics();
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
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _guardianNameController.dispose();
    _abhaController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
            doctorId = homeProvider.doctorProfile!.data!.id;
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Book Appointment',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _nameController,
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
                        controller: _abhaController,
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
                        controller: _ageController,
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
                        controller: _phoneController,
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
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _addressController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            label: const Text('Patient Address'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            )),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter address';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _guardianNameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            label: const Text('Guardian Name'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            )),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter guardian name';
                        //   }
                        //   return null;
                        // },
                      ),

                      const SizedBox(height: 18.0),
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
                              controller: _dateController,
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
                                  // onPressed: () => _selectDate(context),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => _buildCalendarDialog(context),
                                    );
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (_selectedDay == null) {
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
                                final count = _clinicAppointmentCounts?[clinic.id.toString()] ?? 0;
                                return DropdownMenuItem<ClinicDtos>(
                                  value: clinic,
                                  child: Text("${clinic.location!} - $count"),
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
                                  // print(_selectedTime);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: _isBooking ? null : _bookAppointment,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, deviceHeight * 0.06),
                          backgroundColor: AppColors.verdigris,
                        ),
                        child: _isBooking
                            ? const CircularProgressIndicator()
                            : const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        }
    );
  }

  void _filterClinicsByDate(List<ClinicDtos> clinics) {
    if (_selectedDay == null) {
      _filteredClinics = [];
      return;
    }

    // Filter clinics based on the selected date
    final filteredClinics = clinics
        .where((clinic) {
      final operatingDays = clinic.days;
      final dayOfWeek = DateFormat('EEEE').format(_selectedDay).toUpperCase();
      return operatingDays!.contains(dayOfWeek);
    })
        .toList(); // Ensure the result is a List<ClinicDtos>

    print('Filtered Clinics: $filteredClinics');

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

  void _bookAppointment() async{
    if (!_key.currentState!.validate()) {
      return;
    }
    final bookingTime = DateFormat('HH:mm:ss').format(DateFormat('h:mm a').parse(_selectedTime!));
    final bookingDate = DateFormat('yyyy-MM-dd').format(_selectedDay);

        // print(_selectedClinicId!);
        // print(_nameController.text.trim());
        // print(_abhaController.text.trim());
        // print(_ageController.text.trim());
        // print(_phoneController.text.trim());
        // print(_addressController.text.trim());
        // print(_guardianNameController.text.trim());
        // print(_selectedGender!);
        // print(bookingDate);
        // print(bookingTime);
        // print(_selectedClinicLocation!);

   showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: Provider.of<AppointmentProvider>(context, listen: false).bookAppointment(
            _selectedClinicId!,
            _nameController.text.trim(),
            _abhaController.text.trim(),
            _ageController.text.trim(),
            _phoneController.text.trim(),
            _addressController.text.trim(),
            _guardianNameController.text.trim(),
            _selectedGender!,
            bookingDate,
            bookingTime,
            _selectedClinicLocation!,
            widget.patientInfo!.id!
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text('Processing..', style: TextStyle(color: AppColors.textColor, fontSize: 15.0),),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Error booking appointment: ${snapshot.error}'),
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
                content: const Text('Appointment booked successfully!'),
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

  Future<void> _fetchClinicAppointmentCount() async{
    final provider = Provider.of<AppointmentProvider>(context, listen: false);
    await provider.fetchClinicWiseAppointmentCount(DateFormat('yyyy-MM-dd').format(_selectedDay));

    setState(() {
      _clinicAppointmentCounts = provider.clinicWiseAppointmentCounts ?? {};
    });
  }

  void _fetchAppointmentsForCalendar() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.now();
    String startDate = dateFormat.format(DateTime(now.year - 1, 1, 1));
    String endDate = dateFormat.format(DateTime(now.year + 4, 12, 31));

    // Fetch appointment counts for the current visible month
    Provider.of<AppointmentProvider>(context, listen: false)
        .fetchCalendarAppointmentCount(doctorId!, startDate, endDate);
  }

  Widget _buildCalendarDialog(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Consumer<AppointmentProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator()); // Display a loading spinner
            }
            return TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365 * 50)), // 50 years back
              lastDay: DateTime.now().add(const Duration(days: 365 * 50)), // 50 years ahead
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              availableCalendarFormats: const { // Lock the calendar format
                CalendarFormat.month: 'Month',
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDay);
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                    _filterClinicsByDate(_allClinics);
                    _fetchClinicAppointmentCount();
                  // });
                });

                Navigator.pop(context);
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });

                _fetchAppointmentsForCalendar();
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return _buildDateCell(context, day);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDateCell(BuildContext context, DateTime day) {
    final provider = Provider.of<AppointmentProvider>(context);
    final formattedDay = DateFormat('yyyy-MM-dd').format(day);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          day.day.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        if (provider.appointmentCounts != null &&
            provider.appointmentCounts!.containsKey(formattedDay))
          const SizedBox(height: 4), // Adds some space between the date and the count
        if (provider.appointmentCounts != null &&
            provider.appointmentCounts!.containsKey(formattedDay))
            Text(
              provider.appointmentCounts![formattedDay]!.toString(),
              style: const TextStyle(color: AppColors.verdigris, fontSize: 12),
            ),
      ],
    );
  }


}
