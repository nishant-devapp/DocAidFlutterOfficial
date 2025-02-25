import 'package:code/appointments/widgets/print_appointment_text.dart';
import 'package:code/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../home/models/home_get_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/print_content.dart';
import '../models/fetch_appointment_model.dart';

class PrintPatientInfoDesign extends StatefulWidget {
  const PrintPatientInfoDesign({super.key, required this.appointment});

  final AppointmentData appointment;

  @override
  State<PrintPatientInfoDesign> createState() => _PrintPatientInfoDesignState();
}

class _PrintPatientInfoDesignState extends State<PrintPatientInfoDesign> {
  ClinicDtos? clinic;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    fetchClinicDetails();
  }

  void fetchClinicDetails() {
    final clinics = context.read<HomeGetProvider>().getClinics();
    final clinicLocation = widget.appointment.clinicLocation;
    clinic = clinics.firstWhere((clinic) => clinic.location == clinicLocation);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            RepaintBoundary(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(alignment: Alignment.center,child: Text('Booking Confirmed', style: TextStyle(fontWeight: FontWeight.w700, fontSize:25.0),)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Patient Name', text: widget.appointment.name!)),
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'ABHA Number',
                              text: widget.appointment.abhaNumber!)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Age', text: widget.appointment.age.toString())),
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Phone', text: widget.appointment.contact!)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Gender', text: widget.appointment.gender!)),
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Fees', text: '\u{20B9} ${clinic!.clinicNewFees!.toInt().toString()}')),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Clinic Name', text: clinic!.clinicName!)),
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Clinic Location', text: clinic!.location!)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Appointment Date', text: widget.appointment.appointmentDate!)),
                      Expanded(
                          child: PrintAppointmentText(
                              title: 'Appointment Time', text: widget.appointment.appointmentTime!)),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                // change below buttons to icon button
                ElevatedButton.icon(
                  icon: const Icon(Icons.print_sharp, size: 22.0, color: Colors.white,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.verdigris,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      printContent(context, _key, '${widget.appointment.name!}_booking.pdf');
                    });
                  },
                  label: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text('Print', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                  ),
                ),
                // const SizedBox(width: 15.0),
                ElevatedButton.icon(
                  icon: SvgPicture.asset('assets/svg/whatsapp.svg', height: 25.0, width: 25.0,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(color: AppColors.appointmentColor, width: 1.0),
                    ),
                  ),
                  onPressed: () {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   printContent(context, _key, '${widget.appointment.name!}_booking.pdf');
                    // });
                  },
                  label: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text('Send Message', style: TextStyle(fontSize: 16.0, color: AppColors.appointmentColor),),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


}
