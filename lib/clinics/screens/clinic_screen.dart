import 'package:code/clinics/widgets/add_clinic_form.dart';
import 'package:code/clinics/widgets/clinic_item.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ClinicScreen extends StatefulWidget {
  const ClinicScreen({super.key});

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {

  void _openAddClinicBottomSheet(){
    showModalBottomSheet(context: context, builder: (ctx) => AddClinicForm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    onPressed: _openAddClinicBottomSheet,
                    icon: const Icon(Icons.add,
                        size: 35.0, color: AppColors.textColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            ClinicItem(),
          ],
        ),
      ),
    );
  }
}
