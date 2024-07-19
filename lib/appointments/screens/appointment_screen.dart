import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {


  // Initial Selected Value
  String dropDownValue = 'All Clinics';

  // List of items in our dropdown menu
  var items = [
    'All Clinics',
    'Boring Road',
    'Kankarbagh',
    'Patliputra Colony',
    'Rajabazar',
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
