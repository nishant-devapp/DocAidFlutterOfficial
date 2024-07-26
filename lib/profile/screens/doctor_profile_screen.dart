import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../home/provider/home_provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.magnolia,
        title: const Text('Your Profile', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),),
        centerTitle: true,
       ),
      body: DoctorProfileBase(
        builder: (HomeGetProvider homeProvider) {
          final doctorProfile = homeProvider.doctorProfile!;
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: deviceWidth,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.magnolia,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 60.0,
                                backgroundColor: AppColors.ultraViolet,
                                child: Text(
                                  'X',
                                  style: TextStyle(
                                      fontSize: 50.0, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Welcome',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColor),
                                  ),
                                  Text(
                                    '${doctorProfile.data?.firstName ?? ''} ${doctorProfile.data?.lastName ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Email',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor),
                                  ),
                                  Text(
                                    '${doctorProfile.data?.email ?? ''} ',
                                    style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Registration Number',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor),
                                  ),
                                  Text(
                                    '${doctorProfile.data?.licenceNumber ?? ''} ',
                                    style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Phone Number',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              ),
                              Text(
                                '${doctorProfile.data?.contact ?? ''} ',
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.magnolia,
                        ),
                        child:  const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit_note, size: 28, color: AppColors.jet,),
                            SizedBox(width: 10.0),
                            Text('Edit', style: TextStyle(fontSize: 16.0, color: AppColors.textColor),),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Degree', style: TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
