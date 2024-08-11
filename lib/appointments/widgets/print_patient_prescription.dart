import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/print_content.dart';
import '../models/fetch_appointment_model.dart';

class PrintPatientPrescription extends StatefulWidget {
   PrintPatientPrescription({super.key, required this.appointment});

  Data appointment;

  @override
  State<PrintPatientPrescription> createState() => _PrintPatientPrescriptionState();
}

class _PrintPatientPrescriptionState extends State<PrintPatientPrescription> {

  final GlobalKey _key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(
        builder: (HomeGetProvider homeProvider){
          final doctorProfile = homeProvider.doctorProfile!;
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${doctorProfile.data?.firstName ?? ''} ${doctorProfile.data?.lastName ?? ''}',
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor),
                          ),
                        ),
                        const SizedBox(height: 8.0,),
                        Text(
                          doctorProfile.data?.specialization!.first ?? '',
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(
                          doctorProfile.data?.degree!.first ?? '',
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                         const SizedBox(height: 5.0,),
                        Text(
                          doctorProfile.data?.licenceNumber ?? '',
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                         const SizedBox(height: 5.0,),
                        Text("Location: ${widget.appointment.clinicLocation!}",
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(height: 15.0),
                        Container(width: double.infinity, height: 1.5, color: AppColors.jet.withOpacity(0.6),),
                        const SizedBox(height: 15.0),
                        const Text('Patient Details', style: TextStyle(fontSize: 16.0, color: AppColors.textColor, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.appointment.name!),
                            Text(widget.appointment.age.toString()),
                            Text(widget.appointment.gender!),
                            Text(widget.appointment.appointmentDate!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.verdigris,
                        ),
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            printContent(context, _key, '${widget.appointment.name!}_prescription.pdf');
                          });
                        },
                        child: const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text('Print', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.verdigris,
                        ),
                        onPressed: () {

                        },
                        child: const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text('Submit', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
