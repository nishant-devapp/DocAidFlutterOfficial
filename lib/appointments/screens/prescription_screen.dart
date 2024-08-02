import 'dart:convert';
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

  @override
  void initState() {
    super.initState();
    // Provider.of<PrescriptionProvider>(context, listen: false).fetchPrescriptions(widget.appointment.contact!);
    Provider.of<PrescriptionProvider>(context, listen: false)
        .fetchPrescriptions("9305481976");
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
                        child: Text(prescriptionProvider.errorMessage!));
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
    final headerBytes = bytes.sublist(0, 4);
    final headerString = base64Encode(headerBytes);

    if (headerString.startsWith('JVBERi0x')) {
      // PDF Header
      return PDFPreview(bytes: bytes);
    } else if (headerString.startsWith('/9j/') || // JPEG
        headerString.startsWith('iVBOR') || // PNG
        headerString.startsWith('R0lG') || // GIF
        headerString.startsWith('UklGR') || // WEBP
        bytes.length > 2 &&
            bytes[0] == 0xFF &&
            bytes[1] == 0xD8 &&
            bytes[2] == 0xFF) {
      // JPG Magic Number
      return Image.memory(bytes);
    } // Return an Offstage widget for unsupported formats
    return Offstage(child: Container());
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
                _pickImageFromCamera(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.jet,),
              title: const Text('Gallery', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: AppColors.jet,),
              title: const Text('Pick PDF', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
              onTap: () {
                Navigator.pop(context);
                _pickPDFFile(context);
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> _pickImageFromCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final uri = Uri.file(image.path);
      _showSelectedMedia(context, uri);
    }
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final uri = Uri.file(image.path);
      _showSelectedMedia(context, uri);
    }
  }

  Future<void> _pickPDFFile(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      final uri = Uri.file(result.files.single.path!);
      _showSelectedMedia(context, uri);
    }
  }

  void _showSelectedMedia(BuildContext context, Uri uri) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (uri.path.endsWith('.pdf'))
                Container(
                  height: 200,
                  child: const Center(child: Text('PDF Selected')),
                )
              else
                Image.file(File(uri.path), height: 200),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _uploadFile(uri);
                },
                child: Text('Upload File'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _uploadFile(Uri uri) {
    // Implement your file upload logic here
    print('Uploading file: $uri');
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
