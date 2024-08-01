import 'package:code/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/time_formatter.dart';
import '../models/fetch_appointment_model.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key, required this.appointment});

  final Data appointment;

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment.name!),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.appointment.name!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Age',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.appointment.age.toString(),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Phone',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.appointment.contact!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'ABHA Number',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.appointment.abhaNumber!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Appointment Date',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.appointment.appointmentDate!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Appointment Time',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  formatTime(widget.appointment.appointmentTime!),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'assets/svg/print_icon.svg',
                        height: 32,
                        width: 32,
                        colorFilter: const ColorFilter.mode(
                            AppColors.jet, BlendMode.srcIn),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'assets/svg/prescription.svg',
                        height: 38,
                        width: 38,
                        colorFilter: const ColorFilter.mode(
                            AppColors.dashboardColor, BlendMode.srcIn),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'assets/svg/upload_icon.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            AppColors.dashboardColor, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
