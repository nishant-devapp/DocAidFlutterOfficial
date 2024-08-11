import 'dart:io';
import 'dart:typed_data';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:code/utils/helpers/Toaster.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
import '../widgets/edit_profile_form.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {

  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;
  bool _isUpdatingImage = false;

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
          final hasProfileImage = homeProvider.profileImage != null;
          final specialization = doctorProfile.data?.specialization != null && doctorProfile.data!.specialization!.isNotEmpty
              ? doctorProfile.data!.specialization?.first
              : 'No specialization available';
          final degrees = doctorProfile.data?.degree!;
          final experience = doctorProfile.data?.experience!;
          final achievements = doctorProfile.data?.achievements!;
          final researchJournal = doctorProfile.data?.researchJournal!;
          final citations = doctorProfile.data?.citations!;
          final specializations = doctorProfile.data?.specialization!;
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                      backgroundImage: homeProvider.profileImage != null
                                          ? MemoryImage(homeProvider.profileImage!)
                                          : null,
                                      child: homeProvider.profileImage == null
                                          ? Text(
                                        doctorProfile.data?.firstName?.isNotEmpty ?? false
                                            ? doctorProfile.data!.firstName![4].toUpperCase()
                                            : 'X',
                                        style: const TextStyle(fontSize: 25, color: Colors.black),
                                      ): null,
                                    ),
                                    const SizedBox(height: 8.0),
                                    if (hasProfileImage)
                                      ElevatedButton(
                                        onPressed: _isUpdatingImage ? null : _pickImageFromGallery,
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(double.infinity, deviceHeight * 0.05),
                                          backgroundColor: AppColors.verdigris,
                                        ),
                                        child: _isUpdatingImage
                                            ? const CircularProgressIndicator()
                                            : const Text(
                                          'Update Image',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18.0),
                                        ),
                                      )

                                    else
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your logic to add a new image
                                        },
                                        child: Text('Add Image'),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Expanded(
                                child: Column(
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
                                    const SizedBox(height: 5.0),
                                    Text(
                                      '${doctorProfile.data?.firstName ?? ''} ${doctorProfile.data?.lastName ?? ''}',
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
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
                              ),
                              Expanded(
                                child: Column(
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
                                  child: const EditProfileForm(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Specialization', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Text(specialization!, style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                        ),
                        const SizedBox(height: 10.0),
                        const Text('Degree', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: degrees!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text(degrees[index], style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                                  ),
                                );
                              }
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text('Total Experience', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child:  Text("$experience years", style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                        ),
                        const SizedBox(height: 10.0),
                        const Text('Achievements', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: achievements!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text(achievements[index], style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                                  ),
                                );
                              }
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text('Research Journal', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: researchJournal!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text(researchJournal[index], style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                                  ),
                                );
                              }
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text('Citations', style: TextStyle(color: AppColors.textColor, fontSize: 20.0, fontWeight: FontWeight.w700),),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: citations!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text(citations[index], style: const TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),),
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {

        setState(() {
          _selectedFile = File(image.path);
        });
        if (_selectedFile != null) {
          // Replace 'your_token' with the actual token
          await Provider.of<HomeGetProvider>(context, listen: false).updateDoctorImage(
            _selectedFile!
          );
        }


        showToast(context, 'Image Updated Successfully', AppColors.verdigris, Colors.white);

      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image from gallery')),
      );
    }
  }


}
