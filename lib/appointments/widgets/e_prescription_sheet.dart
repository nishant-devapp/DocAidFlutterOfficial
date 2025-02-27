import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../models/fetch_appointment_model.dart';

class EPrescriptionSheet extends StatefulWidget {
  const EPrescriptionSheet({super.key, required this.appointment});

  final AppointmentData appointment;

  @override
  State<EPrescriptionSheet> createState() => _EPrescriptionSheetState();
}

class _EPrescriptionSheetState extends State<EPrescriptionSheet> {
  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final doctorProfile = homeProvider.doctorProfile!;
      final speciality =
          homeProvider.doctorProfile!.data!.specialization!.first;

      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/medical_symbol.svg',
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doctorProfile.data!.firstName!} ${doctorProfile.data!.lastName!}",
                        style: const TextStyle(
                            color: AppColors.verdigris,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        doctorProfile.data!.degree!.first,
                        style: const TextStyle(
                            color: AppColors.verdigris,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        doctorProfile.data!.specialization!.first,
                        style: const TextStyle(
                            color: AppColors.verdigris,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/location_icon.svg',
                        width: 15.0,
                        height: 15.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        widget.appointment.clinicLocation ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/call_icon.svg',
                        width: 15.0,
                        height: 15.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        widget.appointment.contact ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/email_icon.svg',
                    width: 10.0,
                    height: 10.0,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    doctorProfile.data!.email ?? 'N/A',
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: const Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vitals',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('BP'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
