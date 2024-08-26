import 'dart:io';

import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class EditPrescriptionImgSheet extends StatefulWidget {
  EditPrescriptionImgSheet({super.key, required this.clinicId});

  int? clinicId;

  @override
  State<EditPrescriptionImgSheet> createState() =>
      _EditPrescriptionImgSheetState();
}

class _EditPrescriptionImgSheetState extends State<EditPrescriptionImgSheet> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeGetProvider>(context, listen: false)
        .fetchPrescriptionImage(widget.clinicId!);
  }

  @override
  void dispose() {
    super.dispose();
    widget.clinicId = null;
  }

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 100.0,
                  child: homeProvider.prescriptionImage == null
                      ? const Center(child: Text("No image available"))
                      : Image.memory(
                          homeProvider.prescriptionImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              ElevatedButton(onPressed: _pickAndCropImage, child:  Text(_selectedImage == null ? 'Select Image' : 'Update Image'),),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _pickAndCropImage() async {
    try {
      // Pick an image from the gallery
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 32, ratioY: 9),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.verdigris.withOpacity(0.8),
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          ],
        );

        if (croppedFile != null) {
          // Convert CroppedFile to File
          File imageFile = File(croppedFile.path);

          setState(() {
            _selectedImage = imageFile;
          });

          // Automatically upload the image after picking and cropping
          await Provider.of<HomeGetProvider>(context, listen: false)
              .uploadPrescriptionImage(imageFile, widget.clinicId!);
        }
      }
    } catch (e) {
      print("Image picking/cropping failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selection failed!')),
      );
    }
  }


}
