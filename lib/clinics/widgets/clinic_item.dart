import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ClinicItem extends StatefulWidget {
  const ClinicItem({super.key});

  @override
  State<ClinicItem> createState() => _ClinicItemState();
}

class _ClinicItemState extends State<ClinicItem> {
  @override
  Widget build(BuildContext context) {
    return Text('Clinics');
  }
}
