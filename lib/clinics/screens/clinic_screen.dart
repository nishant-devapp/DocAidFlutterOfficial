import 'package:code/clinics/widgets/add_clinic_form.dart';
import 'package:code/clinics/widgets/clinic_charge_dialog.dart';
import 'package:code/clinics/widgets/clinic_item.dart';
import 'package:code/home/models/home_get_model.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';

class ClinicScreen extends StatefulWidget {
  const ClinicScreen({super.key});

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
  }
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Scaffold(
      body: DoctorProfileBase(
        builder: (HomeGetProvider homeProvider) {
          final doctorProfile = homeProvider.doctorProfile!;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ClinicChargeDialog(
                                title: "Additional Clinic Charges",
                                description: "After you add additional clinic, Rs. 500 will be added to your monthly subscription",
                                onAccept: () {
                                  Navigator.of(context).pop();
                                  _openAddClinicBottomSheet(context, null);
                                },
                                onCancel: () {
                                  Navigator.of(context).pop();
                                  // Handle cancel action
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add,
                            size: 35.0, color: AppColors.textColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Expanded(child: ClinicItem()),
              ],
            ),
          );
        },
      ),
    );
  }


  void _openAddClinicBottomSheet(BuildContext context, ClinicDtos? clinic){
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
            child: const AddClinicForm(),
          ),
        ),
      ),
    );
  }



}
