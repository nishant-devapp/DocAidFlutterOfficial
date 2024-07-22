import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Initial Selected Value
  String dropDownValue = 'All Clinics';
  String searchValue = '';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DropdownMenu(
                        enableSearch: false,
                        helperText: 'Select Clinic',
                        initialSelection: 'All Clinics',
                        dropdownMenuEntries: <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(value: 'All Clinics', label: 'All Clinics'),
                          DropdownMenuEntry(value: 'Patliputra', label: 'Patliputra'),
                          DropdownMenuEntry(value: 'Boring Road', label: 'Boring Road'),
                          DropdownMenuEntry(value: 'Kankarbagh', label: 'Kankarbagh'),
                        ]),
                    const Text("Date Picker"),
                    EasySearchBar(
                        title: const Text('Example'),
                        onSearch: (value) => setState(() => searchValue = value),
                        actions: [
                          IconButton(icon: const Icon(Icons.search), onPressed: () {})
                        ],
                        asyncSuggestions: (value) async =>
                        await _fetchSuggestions(value)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
