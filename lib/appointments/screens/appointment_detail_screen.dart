import 'package:code/appointments/screens/prescription_screen.dart';
import 'package:code/appointments/widgets/e_prescription_sheet.dart';
import 'package:code/appointments/widgets/print_patient_info_design.dart';
import 'package:code/appointments/widgets/print_patient_prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/time_formatter.dart';
import '../models/fetch_appointment_model.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key, required this.appointment});

  final AppointmentData appointment;

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {

  ClinicDtos? clinic;
  int? clinicId;

  @override
  void initState() {
    super.initState();
    fetchClinicDetails();
  }

  void fetchClinicDetails() {
    final clinics = context.read<HomeGetProvider>().getClinics();
    final clinicLocation = widget.appointment.clinicLocation;
    clinic = clinics.firstWhere((clinic) => clinic.location == clinicLocation);
    clinicId = clinic!.id!;
    // print(clinicId);
    Provider.of<HomeGetProvider>(context, listen: false).fetchPrescriptionImage(clinicId!);

  }

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final doctorProfile = homeProvider.doctorProfile!;
      final prescriptionImage = homeProvider.prescriptionImage;

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.appointment.name!),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10.0),
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.appointment.name!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Age',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.appointment.age.toString(),
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Phone',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.appointment.contact!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'ABHA Number',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.appointment.abhaNumber!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Appointment Date',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.appointment.appointmentDate!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Appointment Time',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    formatTime(widget.appointment.appointmentTime!),
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
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
                                  child: PrintPatientInfoDesign(appointment: widget.appointment,),
                                ),
                              ),
                            ),
                          );
                        },
                        splashColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/svg/print_icon.svg',
                          height: 32,
                          width: 32,
                          colorFilter: const ColorFilter.mode(
                              AppColors.jet, BlendMode.srcIn),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                var screenSize = MediaQuery.of(context).size;
                                return Dialog(
                                  child: SizedBox(
                                    width: screenSize.width * 0.8, // 80% of screen width
                                    // height: screenSize.height * 0.5, // 50% of screen height
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Select Prescription Option', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: AppColors.textColor),),
                                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.disabled_by_default, size: 30.0, color: AppColors.princetonOrange,),),
                                            ],
                                          ),
                                          const SizedBox(height: 12.0,),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.vermilion,
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor: Colors.white,
                                                builder: (context) => DraggableScrollableSheet(
                                                  expand: false,
                                                  builder: (context, scrollController) => SingleChildScrollView(
                                                    controller: scrollController,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                                      ),
                                                      child: PrintPatientPrescription(appointment: widget.appointment, prescriptionImage: prescriptionImage,),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Padding(
                                              padding:  EdgeInsets.all(8.0),
                                              child: Text('Default Prescription', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                                            ),
                                          ),
                                          const SizedBox(height: 10.0,),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.vermilion,
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor: Colors.white,
                                                builder: (context) => DraggableScrollableSheet(
                                                  expand: false,
                                                  builder: (context, scrollController) => SingleChildScrollView(
                                                    controller: scrollController,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                                      ),
                                                      child: EPrescriptionSheet(appointment: widget.appointment),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Padding(
                                              padding:  EdgeInsets.all(8.0),
                                              child: Text('E-Prescription', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                );
                              }
                          );

                        },
                        splashColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/svg/prescription.svg',
                          height: 38,
                          width: 38,
                          colorFilter: const ColorFilter.mode(
                              AppColors.dashboardColor, BlendMode.srcIn),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrescriptionScreen(appointment: widget.appointment,),
                            ),
                          );
                        },
                        splashColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/svg/upload_icon.svg',
                          height: 30,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                              AppColors.dashboardColor, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      );
  });


  }

  void _fetchPrescriptionImage(int clinicId) {

  }
}
