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
                  margin: const EdgeInsets.only(
                      bottom: 30.0, left: 10.0, right: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
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
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.jet)),
                                  const SizedBox(width: 15.0),
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
                        const SizedBox(height: 10.0),
                        Text(
                          appointment.name ?? 'N/A',
                          style: const TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Ph. No: ${appointment.contact ?? 'N/A'}',
                          style: const TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(appointment.appointmentTime!),
                              style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Visited: ',
                                    style: TextStyle(fontSize: 17.0),
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
