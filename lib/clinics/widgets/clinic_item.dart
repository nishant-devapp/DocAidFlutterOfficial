import 'package:code/clinics/widgets/edit_clinic_form.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/clinic_day_abbreviator.dart';
import 'package:code/utils/helpers/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../appointments/screens/appointment_screen.dart';
import '../../home/provider/home_provider.dart';

class ClinicItem extends StatelessWidget {
  const ClinicItem({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    final deviceHeight = mediaQuery.size.height;

    return Consumer<HomeGetProvider>(
      builder: (context, homeProvider, child) {
        final clinics = homeProvider.getClinics();

        return ListView.builder(
          itemCount: clinics.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final clinic = clinics[index];
            final clinicDays = getAbbreviatedDays(clinic.days!);

            return Card(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                  color: AppColors.textColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              margin: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
                horizontal: deviceWidth * 0.02,
              ),
              elevation: 3,
              shadowColor: AppColors.verdigris.withOpacity(0.4),
              child: Container(
                padding: EdgeInsets.all(deviceWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(clinic.clinicName!,
                            style: TextStyle(
                                fontSize: deviceWidth * 0.05,
                                color: AppColors.princetonOrange,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  // This makes the bottom sheet full screen
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                    expand: false,
                                    builder: (context, scrollController) =>
                                        SingleChildScrollView(
                                      controller: scrollController,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: EditClinicForm(
                                            clinicToEdit: clinic),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/svg/edit_icon.svg',
                                height: 22,
                                width: 22,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.dashboardColor, BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(width: deviceWidth * 0.05),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete Clinic'),
                                        content: const Text(
                                            'Are you sure you want to delete this clinic ?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16.0))),
                                          TextButton(
                                              onPressed: () {
                                                Provider.of<HomeGetProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteClinic(clinic.id!);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16.0),
                                              )),
                                        ],
                                      );
                                    });
                              },
                              child: SvgPicture.asset(
                                'assets/svg/delete_icon.svg',
                                height: 22,
                                width: 22,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.vermilion, BlendMode.srcIn),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/location_icon.svg',
                          height: 18,
                          width: 18,
                          colorFilter: const ColorFilter.mode(
                              AppColors.dashboardColor, BlendMode.srcIn),
                        ),
                        SizedBox(width: deviceWidth * 0.02),
                        Text(clinic.location!,
                            style: TextStyle(
                                fontSize: deviceWidth * 0.04,
                                color: AppColors.textColor.withOpacity(0.8),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/call_icon.svg',
                          height: 18,
                          width: 18,
                          colorFilter: const ColorFilter.mode(
                              AppColors.dashboardColor, BlendMode.srcIn),
                        ),
                        SizedBox(width: deviceWidth * 0.02),
                        Text("+91 ${clinic.clinicContact!}",
                            style: TextStyle(
                                fontSize: deviceWidth * 0.04,
                                color: AppColors.textColor.withOpacity(0.8),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const Divider(),
                    Text('Days', style: TextStyle(color: AppColors.princetonOrange, fontSize: deviceHeight * 0.018),),
                    SizedBox(height: deviceHeight * 0.001),
                    Text(
                      clinicDays,
                      style: TextStyle(
                          fontSize: deviceWidth * 0.04,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Compounder Name', style: TextStyle(color: AppColors.princetonOrange, fontSize: deviceHeight * 0.018),),
                              SizedBox(height: deviceHeight * 0.001),
                              Text(
                                clinic.incharge!,
                                style: TextStyle(
                                    fontSize: deviceWidth * 0.04,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Timings', style: TextStyle(color: AppColors.princetonOrange, fontSize: deviceHeight * 0.018),),
                              SizedBox(height: deviceHeight * 0.001),
                              Text(
                                "${formatTime(clinic.startTime!)} - ${formatTime(clinic.endTime!)}",
                                style: TextStyle(
                                    fontSize: deviceWidth * 0.04,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('New Patient Fees', style: TextStyle(color: AppColors.princetonOrange, fontSize: deviceHeight * 0.018),),
                              SizedBox(height: deviceHeight * 0.001),
                              Text(
                                'Rs. ${clinic.clinicNewFees}',
                                style: TextStyle(
                                    fontSize: deviceWidth * 0.04,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Old Patient Fees', style: TextStyle(color: AppColors.princetonOrange, fontSize: deviceHeight * 0.018),),
                              SizedBox(height: deviceHeight * 0.001),
                              Text(
                                'Rs. ${clinic.clinicOldFees}',
                                style: TextStyle(
                                    fontSize: deviceWidth * 0.04,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(
                                selectedClinicId: clinic.id,
                                selectedClinicName: clinic.clinicName,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.02),
                          backgroundColor: AppColors.verdigris,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Check Appointments',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
