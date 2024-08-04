import 'dart:io';
import 'package:code/appointments/providers/prescription_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/fetch_appointment_model.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key, required this.appointment});

  final Data appointment;

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
                      fontWeight: FontWeight.w600, fontSize: 22.0),
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
                        final mediaBytes =
                            prescriptionProvider.mediaItems[index];

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

  Widget _buildPrescriptionPreview(Uint8List bytes) {
    if (bytes.isEmpty) return Offstage(child: Container()); // Handle empty bytes

    // Check for image formats using common magic numbers
    final isJpeg = bytes.length > 2 && bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;
    final isPng = bytes.length > 8 && bytes.sublist(1, 8).join() == '89504E47'; // PNG Magic Number
    final isGif = bytes.length > 6 && bytes.sublist(0, 6).join() == '474946'; // GIF Magic Number
    final isWebp = bytes.length > 12 && bytes.sublist(0, 12).join() == '52494646'; // WEBP Magic Number

    if (isJpeg || isPng || isGif || isWebp) {
      return Card(
        elevation: 3,
        shadowColor: AppColors.princetonOrange.withOpacity(0.5),
        color: AppColors.celeste.withOpacity(0.6),
        child: SizedBox(
          height: 300.0,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.memory(bytes),
          ),
        ),
      );
    }

    // If not an image, assume it's a PDF
    return Card(
      elevation: 3,
      shadowColor: AppColors.princetonOrange.withOpacity(0.5),
      color: AppColors.celeste.withOpacity(0.6),
      child: SizedBox(
        height: 300.0,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PDFPreview(bytes: bytes), // Ensure this widget is set up correctly to handle PDFs
        ),
      ),
    );
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
        setState(() {
          _selectedFile = File(image.path);
        });
        _showSelectedMedia(_selectedFile!);
      }
    } catch (e) {
      print('Error picking image from camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image from camera')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedFile = File(image.path);
        });
        _showSelectedMedia(_selectedFile!);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image from gallery')),
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
        SnackBar(content: Text('Failed to pick PDF file')),
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
