import 'package:code/home/provider/home_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProfileBase extends StatefulWidget {
  const DoctorProfileBase({super.key, required this.builder });

  final Widget Function(HomeGetProvider homeProvider) builder;

  @override
  State<DoctorProfileBase> createState() => _DoctorProfileBaseState();
}

class _DoctorProfileBaseState extends State<DoctorProfileBase> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
      if (homeProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (homeProvider.errorMessage != null) {
        return Center(child: Text('Error: ${homeProvider.errorMessage}'));
      } else if (homeProvider.doctorProfile != null) {
        return widget.builder(homeProvider);
      } else {
        return const Center(child: Text('No data available', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: AppColors.textColor),));
      }
    });
  }
}
