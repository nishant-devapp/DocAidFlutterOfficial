import 'package:code/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final doctorProvider = Provider.of<HomeProvider>(context);
    final doctorInfo = doctorProvider.homeGet;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text(doctorInfo!.firstName, style: const TextStyle(fontSize: 22),)),
          ],
        ),
      ),
    );
  }
}
