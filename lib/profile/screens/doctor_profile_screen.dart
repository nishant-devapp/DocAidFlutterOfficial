import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
        if (homeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeProvider.errorMessage != null) {
          return Center(child: Text('Error: ${homeProvider.errorMessage}'));
        } else if (homeProvider.doctorProfile != null) {
          final doctorProfile = homeProvider.doctorProfile!;
          return  SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  doctorProfile.data?.firstName ?? '',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ))
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      }),
    );
  }
}
