import 'package:code/appointments/widgets/appointment_loading_shimmer.dart';
import 'package:code/appointments/widgets/book_appointment_abha_phone_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../home/models/home_get_model.dart';
import '../../utils/constants/colors.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../models/fetch_appointment_model.dart' as appointment_data;
import '../models/fetch_appointment_model.dart';
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

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

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
                      Expanded(child: Lottie.asset('assets/lottie/no_data_lottie.json')),
                      const SizedBox(height: 15.0),
                      const Expanded(
                        child: Text(
                          'No appointments available on this date..',
                          style: TextStyle(
                              color: AppColors.verdigris,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ); // Show error message if there is an error
              } else {
                List<appointment_data.AppointmentData> filteredAppointments =
                    appointmentProvider.appointments!.data!;
                if (searchValue.isNotEmpty) {
                  filteredAppointments =
                      filteredAppointments.where((appointment) {
                    return appointment.name!
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()) ||
                        appointment.contact!
                            .toLowerCase()
                            .contains(searchValue.toLowerCase());
                  }).toList();
                }
                content = AppointmentItem(
                    appointmentList:
                        AppointmentList(data: filteredAppointments));

                // content = AppointmentItem(appointmentList: appointmentProvider.appointments!);
              }

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(deviceWidth * 0.03),
                  child: Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(deviceWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.03),
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
                                              newValue?.location;
                                          allClinicsSelected = newValue == null;
                                          _fetchAppointments();
                                        });
                                      },
                                      items: clinicsWithAll
                                          .map<DropdownMenuItem<ClinicDtos?>>(
                                              (ClinicDtos? clinic) {
                                        return DropdownMenuItem<ClinicDtos?>(
                                          value: clinic,
                                          child: Text(
                                              clinic?.location ?? 'All Clinics'),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: deviceWidth * 0.03),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search by Name or Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    searchValue = ''; // Clear the search value
                                  });
                                },
                                icon: const Icon(Icons.highlight_remove),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchValue = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: deviceHeight * 0.02),
                        // I want search button here
                        Flexible(child: content),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (BuildContext context) {
              return const BookAppointmentAbhaPhoneSheet();
            },
          );
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
      } else {
        await appointmentProvider.fetchClinicAppointments(_selectedClinicId!,
            DateFormat('yyyy-MM-dd').format(_selectedDate!));
      }
    }
  }
}
