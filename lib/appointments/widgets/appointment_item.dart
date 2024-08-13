import 'package:code/appointments/widgets/edit_appointment_form.dart';
import 'package:code/utils/helpers/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:code/appointments/widgets/paid_text_design.dart';
import 'package:code/appointments/widgets/unpaid_text_design.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/fetch_appointment_model.dart';
import '../providers/appointment_provider.dart';
import '../screens/appointment_detail_screen.dart';

class AppointmentItem extends StatelessWidget {
  final AppointmentList? appointmentList;

  const AppointmentItem(
      {super.key, this.appointmentList, AppointmentList? appointments});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final appointments = appointmentList?.data ?? [];

    return Consumer<AppointmentProvider>(
      builder: (context, appointmentProvider, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentDetailScreen(
                        appointment: appointment,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  shadowColor: AppColors.verdigris.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.05,
                    horizontal: screenWidth * 0.03,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text('${index + 1}.',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.jet)),
                                  SizedBox(width: screenWidth * 0.04),
                                  appointment.paymentStatus == 'PAID'
                                      ? PaidTextDesign(
                                          appointmentId: appointment.id!,
                                        )
                                      : UnpaidTextDesign(
                                          appointmentId: appointment.id!,
                                          clinicLocation:
                                              appointment.clinicLocation!,
                                        ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true, // This makes the bottom sheet full screen
                                  builder: (context) => DraggableScrollableSheet(
                                    expand: false,
                                    builder: (context, scrollController) => SingleChildScrollView(
                                      controller: scrollController,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: EditAppointmentForm(appointment: appointment,),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/svg/edit_icon.svg',
                                height: 24,
                                width: 24,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.dashboardColor, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth * 0.03),
                        Text(
                          appointment.name ?? 'N/A',
                          style: TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Ph. No: ${appointment.contact ?? 'N/A'}',
                          style: TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(appointment.appointmentTime!),
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Visited: ',
                                    style: TextStyle(fontSize: screenWidth * 0.045),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: AppColors.verdigris,
                                    value: appointment.appointmentvisitStatus ==
                                        'VISITED',
                                    onChanged: (value) async {
                                      if (value != null) {
                                        await Provider.of<AppointmentProvider>(
                                                context,
                                                listen: false)
                                            .updateAppointmentVisitStatus(
                                                appointment.id!, value);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
