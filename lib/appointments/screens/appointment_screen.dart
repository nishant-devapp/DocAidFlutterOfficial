import 'package:code/home/models/home_get_model.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../widgets/appointment_item.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Initial Selected Value
  String dropDownValue = 'All Clinics';
  String searchValue = '';

  String? _selectedClinicName;
  int? _selectedClinicId;
  Clinics? selectedClinic;
  bool allClinicsSelected = true;
  DateTime? _selectedDate;

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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      body: DoctorProfileBase(
        builder: (HomeGetProvider homeProvider) {
          final doctorProfile = homeProvider.doctorProfile!;
          final clinics = homeProvider.getClinics();
          final clinicsWithAll = [null, ...clinics]; // To Add "All Clinics" option here
          // Check if "All Clinics" is selected when screen starts
          if (allClinicsSelected && selectedClinic == null) {
            selectedClinic = null;
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
                          child:  Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Clinics?>(
                                hint: const Text('Select Clinic'),
                                value: selectedClinic,
                                onChanged: (Clinics? newValue) {
                                  setState(() {
                                    selectedClinic = newValue;
                                    _selectedClinicId = newValue?.id;
                                    _selectedClinicName = newValue?.clinicName;
                                    allClinicsSelected = newValue == null;
                                  });
                                },
                                items: clinicsWithAll.map<DropdownMenuItem<Clinics?>>((Clinics? clinic) {
                                  return DropdownMenuItem<Clinics?>(
                                    value: clinic,
                                    child: Text(clinic?.clinicName ?? 'All Clinics'),
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
                                icon: const Icon(Icons.calendar_today_outlined),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                   AppointmentItem(clinicId: _selectedClinicId, date: _selectedDate,),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showToast(context, "Add Appointment Pressed!!");
        },
        backgroundColor: AppColors.verdigris,
        foregroundColor: Colors.white,
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
      });
    }
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

}
