import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';

class ClinicItem extends StatefulWidget {
  const ClinicItem({super.key});

  @override
  State<ClinicItem> createState() => _ClinicItemState();
}

class _ClinicItemState extends State<ClinicItem> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeGetProvider>(context, listen: false);
      if (provider.doctorProfile == null) {
        provider.fetchDoctorProfile();
      }
    });
  }

  List days = ['M W F', 'T Th Sa', 'M F S'];

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        final doctorProfile = homeProvider.doctorProfile!;
        final clinics = homeProvider.getClinics();
       // print(clinics.length);
        return Expanded(
          child: ListView.builder(
            itemCount: clinics.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
        // print('Index: $index, Clinics Length: ${clinics.length}');
              final clinic = clinics[index];
              return Card(
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
                elevation: 10,
                shadowColor: AppColors.verdigris.withOpacity(0.4),
                child: Container(
                  // color: Colors.white,
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            clinic.incharge!,
                            style: const TextStyle(fontSize: 14),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            clinic.clinicContact!,
                            style: const TextStyle(fontSize: 14),
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
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                              ),
                              const SizedBox(
                                width: 3.0,
                              ),
                              Text(
                                clinic.startTime!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            days[index],
                            style:
                            const TextStyle(fontSize: 18, color: AppColors.vermilion, fontWeight: FontWeight.w600),
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
                              // Add onPressed logic for the first button
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              backgroundColor: AppColors.lightGrey,
                              // Color of the first button
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20), // Curvature of 10px
                              ),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16), // Text color
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                // Add onPressed logic for the second button
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                backgroundColor: AppColors.verdigris,
                                // Color of the second button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // Curvature of 10px
                                ),
                              ),
                              child: const Text(
                                'Check Appointments',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16), // Text color
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
          ),
        );
      },
    );
  }
}
