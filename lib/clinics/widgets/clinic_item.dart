import 'package:code/clinics/widgets/edit_clinic_form.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/clinic_day_abbreviator.dart';
import 'package:code/utils/helpers/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../appointments/screens/appointment_screen.dart';
import '../../home/provider/home_provider.dart';
import 'add_clinic_form.dart';

class ClinicItem extends StatelessWidget {
  const ClinicItem({super.key});

  @override
  Widget build(BuildContext context) {
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
              margin: const EdgeInsets.only(
                  bottom: 30.0, left: 10.0, right: 10.0),
              elevation: 10,
              shadowColor: AppColors.verdigris.withOpacity(0.4),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(clinic.clinicName!,
                            style: const TextStyle(
                                fontSize: 22,
                                color: AppColors.princetonOrange,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: AppColors.vermilion,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              clinic.location!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Visiting New Patient Fees',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Rs. ${clinic.clinicNewFees}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Visiting Old Patient Fees',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Rs. ${clinic.clinicOldFees}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Compounder: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          clinic.incharge!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Phone No.: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          clinic.clinicContact!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Time: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              "${formatTime(clinic.startTime!)} - ${formatTime(clinic.endTime!)}",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              clinicDays,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.vermilion,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        TextButton(
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
                                    child: EditClinicForm(clinicToEdit: clinic),
                                  ),
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: AppColors.lightGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
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
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              backgroundColor: AppColors.verdigris,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Check Appointments',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16),
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
