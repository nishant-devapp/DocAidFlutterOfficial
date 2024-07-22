import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

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

  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

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

  // List of items in our dropdown menu
  var items = [
    'All Clinics',
    'Boring Road',
    'Kankarbagh',
    'Patliputra Colony',
    'Rajabazar',
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: dropDownValue,
                        items: <String>[
                          'All Clinics',
                          'Boring Road',
                          'Kankarbagh',
                          'Patliputra Colony',
                          'Rajabazar',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Select Clinic',
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
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
              ),
              const AppointmentItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toastification.showCustom(
          context: context, // optional if you use ToastificationWrapper
            autoCloseDuration: const Duration(seconds:3),
          alignment: Alignment.bottomCenter,
          builder: (BuildContext context, ToastificationItem holder) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.celeste,
                ),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(8),
                child: const Text('This is a toast message!',
                    style: TextStyle(color: AppColors.textColor)),
              ),
            );
          },
        );
        },
        backgroundColor: AppColors.verdigris,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
