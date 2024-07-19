import 'package:flutter/material.dart';

class AddClinicForm extends StatefulWidget {
  const AddClinicForm({super.key});

  @override
  State<AddClinicForm> createState() => _AddClinicFormState();
}

class _AddClinicFormState extends State<AddClinicForm> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text('Clinic Name'),
            ),
          ),
        ],
      ),
    );
  }
}
