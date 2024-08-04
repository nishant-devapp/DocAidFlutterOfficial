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
                        const SizedBox(height: 20.0,),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.verdigris,
                        ),
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            printContent(_key,PrintAlignment.topLeft);
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
