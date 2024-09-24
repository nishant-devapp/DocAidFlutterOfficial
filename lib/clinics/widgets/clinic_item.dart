import 'package:code/clinics/widgets/edit_clinic_form.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/clinic_day_abbreviator.dart';
import 'package:code/utils/helpers/time_formatter.dart';
import 'package:flutter/material.dart';
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
              ),
              margin: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
                horizontal: deviceWidth * 0.02,
              ),
              elevation: 10,
              shadowColor: AppColors.verdigris.withOpacity(0.4),
              child: Container(
                padding: EdgeInsets.all(deviceWidth * 0.04),
                child: Column(
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
                            const Icon(
                              Icons.location_pin,
                              color: AppColors.vermilion,
                            ),
                            SizedBox(width: deviceWidth * 0.01),
                            Text(
                              clinic.location!,
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.04,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Visiting New Patient Fees',
                            style: TextStyle(
                                fontSize: deviceWidth * 0.04,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Rs. ${clinic.clinicNewFees}',
                          style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Visiting Old Patient Fees',
                            style: TextStyle(
                                fontSize: deviceWidth * 0.04,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Rs. ${clinic.clinicOldFees}',
                          style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Row(
                      children: [
                        Text(
                          "Compounder: ",
                          style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        SizedBox(width: deviceWidth * 0.01),
                        Text(
                          clinic.incharge!,
                          style: TextStyle(
                            fontSize: deviceWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Row(
                      children: [
                        Text(
                          "Phone No.: ",
                          style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        SizedBox(width: deviceWidth * 0.01),
                        Text(
                          clinic.clinicContact!,
                          style: TextStyle(
                            fontSize: deviceWidth * 0.038,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Time: ",
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                            ),
                            SizedBox(width: deviceWidth * 0.01),
                            Text(
                              "${formatTime(clinic.startTime!)} - ${formatTime(clinic.endTime!)}",
                              style: TextStyle(
                                fontSize: deviceWidth * 0.036,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              clinicDays,
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.04,
                                  color: AppColors.vermilion,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  AlertDialog(
                                    title: const Text('Delete Clinic'),
                                    content: const Text('Are you sure you want to delete this clinic ?'),
                                    actions: [
                                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Cancel', style: TextStyle(color: Colors.blue, fontSize: 16.0))),
                                      TextButton(onPressed: (){
                                        Provider.of<HomeGetProvider>(context, listen: false)
                                            .deleteClinic(clinic.id!);
                                        Navigator.pop(context);
                                      }, child: const Text('Delete', style: TextStyle(color: Colors.red, fontSize: 16.0),)),
                                    ],
                                  );
                                });
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.02),
                        ),
                        SizedBox(width: deviceWidth * 0.02),
                        // Add some space between buttons

                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              // This makes the bottom sheet full screen
                              builder: (context) => DraggableScrollableSheet(
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
                                    child: EditClinicForm(clinicToEdit: clinic),
                                  ),
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.02),
                            backgroundColor: AppColors.lightGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: deviceWidth * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(width: deviceWidth * 0.02),
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
                      ],
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
