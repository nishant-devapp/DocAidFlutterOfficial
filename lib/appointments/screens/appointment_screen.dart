import 'package:code/appointments/widgets/appointment_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../home/models/home_get_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/Toaster.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../providers/appointment_provider.dart';
import '../widgets/appointment_item.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen(
      {super.key, this.selectedClinicId, this.selectedClinicName});

  final int? selectedClinicId;
  final String? selectedClinicName;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Initial Selected Value
  String dropDownValue = 'All Clinics';
  String searchValue = '';

  String? _selectedClinicName;
  int? _selectedClinicId;
  ClinicDtos? selectedClinic;
  bool allClinicsSelected = true;
  DateTime? _selectedDate;
  List<Data> _filteredAppointments = [];

  final TextEditingController _dateController = TextEditingController();

  final List<String> _suggestions = [
    'Rahul',
    'Nishant',
    'Akansha',
    'Fatima',
    'Anish',
    'Subham',
    'Sameer',
    'Niraj',
    'Raju',
    'Manish'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);

    // Set the selected clinic based on the passed details
    if (widget.selectedClinicId != null) {
      _selectedClinicId = widget.selectedClinicId;
      _selectedClinicName = widget.selectedClinicName;
      allClinicsSelected = false;
    } else {
      _selectedClinicId = null;
      _selectedClinicName = null;
      allClinicsSelected = true;
    }

    _fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;
    Widget content;

    return Scaffold(
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          return DoctorProfileBase(
            builder: (HomeGetProvider homeProvider) {
              final doctorProfile = homeProvider.doctorProfile!;
              final clinics = homeProvider.getClinics();
              final clinicsWithAll = [
                null,
                ...clinics
              ]; // To Add "All Clinics" option here
              // Check if "All Clinics" is selected when screen starts
              if (allClinicsSelected && selectedClinic == null) {
                selectedClinic = null;
              }

              if (appointmentProvider.isLoading) {
                content =
                    const AppointmentShimmer(); // Show shimmer effect when loading
              } else if (appointmentProvider.errorMessage != null ||
                  appointmentProvider.appointments?.data == null) {
                content = Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/no_data_lottie.json'),
                      const SizedBox(height: 15.0),
                      const Text(
                        'No appointments available on this date..',
                        style: TextStyle(
                            color: AppColors.verdigris,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ); // Show error message if there is an error
              } else {
                content = AppointmentItem(
                    appointmentList: appointmentProvider.appointments!);
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.princetonOrange,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<ClinicDtos?>(
                                    hint: const Text('Select Clinic'),
                                    value: _selectedClinicId == null
                                        ? null
                                        : clinics.firstWhere((clinic) =>
                                            clinic.id == _selectedClinicId),
                                    onChanged: (ClinicDtos? newValue) {
                                      setState(() {
                                        selectedClinic = newValue;
                                        _selectedClinicId = newValue?.id;
                                        _selectedClinicName =
                                            newValue?.clinicName;
                                        allClinicsSelected = newValue == null;
                                        _fetchAppointments();
                                      });
                                    },
                                    items: clinicsWithAll
                                        .map<DropdownMenuItem<ClinicDtos?>>(
                                            (ClinicDtos? clinic) {
                                      return DropdownMenuItem<ClinicDtos?>(
                                        value: clinic,
                                        child: Text(clinic?.clinicName ??
                                            'All Clinics'),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
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
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(child: content),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showToast(context, "Add Appointment Pressed!!");
        },
        backgroundColor: AppColors.verdigris,
        foregroundColor: Colors.white,
        splashColor: AppColors.princetonOrange,
        child: const Icon(Icons.add),
      ),
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
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _fetchAppointments();
      });
    }
  }

  Future<void> _fetchAppointments() async {
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    if (_selectedDate != null) {
      if (allClinicsSelected) {
        await appointmentProvider.fetchAllAppointments(
            DateFormat('yyyy-MM-dd').format(_selectedDate!));
        // await appointmentProvider.fetchAllAppointments('2024-07-28');
      } else {
        await appointmentProvider.fetchClinicAppointments(_selectedClinicId!,
            DateFormat('yyyy-MM-dd').format(_selectedDate!));
      }
    }
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }
}
