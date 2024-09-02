import 'dart:io';
import 'package:code/appointments/providers/prescription_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/fetch_appointment_model.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key, required this.appointment});

  final AppointmentData appointment;

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {

  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    Provider.of<PrescriptionProvider>(context, listen: false).fetchPrescriptions(widget.appointment.contact!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.appointment.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20.0),
                ),
                IconButton(
                    onPressed: () => _showMediaOptions(context),
                    icon: const Icon(
                      Icons.add,
                      size: 35.0,
                    ))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Consumer<PrescriptionProvider>(
                builder: (context, prescriptionProvider, child) {
                  if (prescriptionProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (prescriptionProvider.errorMessage != null) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/lottie/no_prescription_lottie.json'),
                          const SizedBox(height: 15.0),
                          const Text(
                            'No prescription found !!',
                            style: TextStyle(
                                color: AppColors.verdigris,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: prescriptionProvider.mediaItems.length,
                      itemBuilder: (context, index) {
                        // final mediaBytes = prescriptionProvider.mediaItems[index];                 // normal list
                        final mediaBytes = prescriptionProvider.mediaItems.reversed.toList()[index]; // reversed list

                        return _buildPrescriptionPreview(mediaBytes);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isPDF(Uint8List bytes) {
    if (bytes.length < 5) return false;
    return bytes[0] == 0x25 && // %
        bytes[1] == 0x50 && // P
        bytes[2] == 0x44 && // D
        bytes[3] == 0x46 && // F
        bytes[4] == 0x2D; // -
  }

  Widget _buildPrescriptionPreview(Uint8List bytes) {
    if (bytes.isEmpty) return const Offstage(); // Handle empty bytes

    if (_isPDF(bytes)) {
      return Card(
        elevation: 3,
        shadowColor: AppColors.princetonOrange.withOpacity(0.5),
        color: Colors.white,
        child: SizedBox(
          height: 300.0,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PDFPreview(bytes: bytes), // Render as PDF
          ),
        ),
      );
    } else {
      // Assume it's an image
      final image = Image.memory(bytes, fit: BoxFit.contain);
      return Card(
        elevation: 3,
        shadowColor: AppColors.princetonOrange.withOpacity(0.5),
        color: Colors.white,
        child: SizedBox(
          height: 300.0,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: image, // Render as image
          ),
        ),
      );
    }
  }

  void _showMediaOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.jet,),
              title: const Text('Camera', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.jet,),
              title: const Text('Gallery', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: AppColors.jet,),
              title: const Text('Pick PDF', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
              onTap: () {
                Navigator.pop(context);
                _pickPDFFile();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File? compressedFile = await _compressImage(File(image.path));
        setState(() {
          _selectedFile = compressedFile;
        });
        _showSelectedMedia(_selectedFile!);
      }
    } catch (e) {
      print('Error picking image from camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image from camera')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File? compressedFile = await _compressImage(File(image.path));
        setState(() {
          _selectedFile = compressedFile;
        });
        _showSelectedMedia(_selectedFile!);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image from gallery')),
      );
    }
  }

  Future<void> _pickPDFFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
        _showSelectedMedia(_selectedFile!);
      }
    } catch (e) {
      print('Error picking PDF file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick PDF file')),
      );
    }
  }

  void _showSelectedMedia(File file) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (file.path.endsWith('.pdf'))
                const SizedBox(
                  height: 200,
                  child: Center(child: Text('PDF Selected', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),)),
                )
              else if (file.existsSync())
                Image.file(file, height: 300,)
              else
                Container(),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verdigris,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _uploadFile(file, widget.appointment.contact!);
                },
                child: const Text('Upload File',style: TextStyle(fontSize: 18.0, color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }

  void _uploadFile(File file, String contact) async{
    // Implement your file upload logic here
    print('Uploading file: $file');
    if (file != null) {
      await Provider.of<PrescriptionProvider>(context, listen: false).uploadPrescription(
        contact,
        file,
      );
    }
  }

  Future<File?> _compressImage(File file) async {
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      // minWidth: 800,
      // minHeight: 800,
      quality: 80,
    );
    if (compressedBytes == null) return null;

    // Create a new file with the compressed image data
    final compressedFile = File(file.path);
    await compressedFile.writeAsBytes(compressedBytes);
    return compressedFile;
  }

}

class PDFPreview extends StatelessWidget {
  final Uint8List bytes;

  const PDFPreview({super.key, required this.bytes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PDFView(
        pdfData: bytes,
      ),
    );
  }
}
