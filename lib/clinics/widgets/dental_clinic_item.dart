import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../appointments/screens/appointment_screen.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/clinic_day_abbreviator.dart';
import '../../utils/helpers/time_formatter.dart';

class DentalClinicItem extends StatelessWidget {
  const DentalClinicItem({super.key});

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
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/edit_icon.svg',
                                height: 22,
                                width: 22,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.dashboardColor, BlendMode.srcIn),
                              ),
                              SizedBox(width: deviceWidth * 0.05),
                              SvgPicture.asset(
                                'assets/svg/delete_icon.svg',
                                height: 22,
                                width: 22,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.vermilion, BlendMode.srcIn),
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
                      SizedBox(height: deviceHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
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
                          SizedBox(width: deviceWidth * 0.01),
                          TextButton(
                            onPressed: () {
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   // This makes the bottom sheet full screen
                              //   builder: (context) => DraggableScrollableSheet(
                              //     expand: false,
                              //     builder: (context, scrollController) =>
                              //         SingleChildScrollView(
                              //           controller: scrollController,
                              //           child: Padding(
                              //             padding: EdgeInsets.only(
                              //               bottom: MediaQuery.of(context)
                              //                   .viewInsets
                              //                   .bottom,
                              //             ),
                              //             child: EditClinicForm(clinicToEdit: clinic),
                              //           ),
                              //         ),
                              //   ),
                              // );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.02, horizontal: deviceWidth * 0.05),
                              // backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: AppColors.verdigris,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              'Details',
                              style: TextStyle(
                                color: AppColors.verdigris,
                                fontSize: deviceWidth * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
