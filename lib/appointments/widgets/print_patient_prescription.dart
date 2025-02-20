import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';
import '../models/fetch_appointment_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../providers/prescription_provider.dart';


class PrintPatientPrescription extends StatefulWidget {
  PrintPatientPrescription({super.key, required this.appointment, required this.prescriptionImage});

  AppointmentData appointment;
  Uint8List? prescriptionImage;

  @override
  State<PrintPatientPrescription> createState() =>
      _PrintPatientPrescriptionState();
}

class _PrintPatientPrescriptionState extends State<PrintPatientPrescription> {
  final GlobalKey _key = GlobalKey();
  bool _isSubmitting = false;


  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final doctorProfile = homeProvider.doctorProfile!;
      final speciality = homeProvider.doctorProfile!.data!.specialization!.first;
      Widget headerWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${doctorProfile.data?.firstName ?? ''} ${doctorProfile.data?.lastName ?? ''}',
              style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor),
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Text(
            doctorProfile.data?.specialization!.first ?? '',
            style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            doctorProfile.data?.degree!.first ?? '',
            style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            doctorProfile.data?.licenceNumber ?? '',
            style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            "Location: ${widget.appointment.clinicLocation!}",
            style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 1.5,
            color: AppColors.jet.withOpacity(0.6),
          ),
        ],
      );

      // if (widget.prescriptionImage != null) {
      //   print('Image data length: ${widget.prescriptionImage!.length}');
      //   print(widget.prescriptionImage);
      // }

      if (widget.prescriptionImage != null && widget.prescriptionImage!.isNotEmpty) {
        try {
          headerWidget = SizedBox(
            width: double.infinity,
            child: Image.memory(
              widget.prescriptionImage!,
              fit: BoxFit.cover,
            ),
          );
        } catch (e) {
          print('Error displaying image: $e');
        }
      }

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
                    headerWidget,
                    const SizedBox(height: 8.0),
                    const Text(
                      'Patient Details',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.appointment.name!,
                          style: const TextStyle(
                              fontSize: 10.0, color: AppColors.textColor),
                        ),
                        Text(
                          widget.appointment.age.toString(),
                          style: const TextStyle(
                              fontSize: 10.0, color: AppColors.textColor),
                        ),
                        Text(
                          widget.appointment.gender!,
                          style: const TextStyle(
                              fontSize: 10.0, color: AppColors.textColor),
                        ),
                        Text(
                          widget.appointment.appointmentDate!,
                          style: const TextStyle(
                              fontSize: 10.0, color: AppColors.textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Diagnosis',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        // SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Height:-',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const SizedBox(
                                  width: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,

                                  ),
                                ),
                                Text(
                                  'Weight:-',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const SizedBox(
                                  width: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  'BP:-',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const SizedBox(
                                  width: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                  ),
                                ),
                                const Text('/',style: TextStyle(
                                  fontSize: 15
                                ),),
                                const SizedBox(
                                  width: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                  ),
                                ),
                                Text(
                                  'Sugar:-',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const SizedBox(
                                  width: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                                  ),
                                  keyboardType: TextInputType.multiline,   // Allows multi-line input
                                  textInputAction: TextInputAction.newline, // Changes the action to new line
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 10.0, // Set the font size to 10
                                  ),
                                  showCursor: false,  // Shows cursor
                                  maxLines: null,    // Allows unlimited lines (null will allow the TextField to grow vertically)
                                  minLines: 1,       // Minimum number of lines to display
                                ),
                              ),
                              const SizedBox(height: 30.0,),
                              Align(alignment:AlignmentDirectional.topStart,child: Image.asset('assets/icons/rx.jpg', height: 30, width: 30.0,)),
                              const SizedBox(height: 30.0,),

                              const SizedBox(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                                  ),
                                  keyboardType: TextInputType.multiline,   // Allows multi-line input
                                  textInputAction: TextInputAction.newline, // Changes the action to new line
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 10.0, // Set the font size to 10
                                  ),
                                  showCursor: false,  // Shows cursor
                                  maxLines: null,    // Allows unlimited lines (null will allow the TextField to grow vertically)
                                  minLines: 1,       // Minimum number of lines to display
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (speciality == 'Dentist' || speciality == 'dentist')
                          Expanded(child: Image.asset('assets/icons/prescriptions_dentist.png', height: 250)),
                        if (speciality == 'Eye Specialist' || speciality == 'eye specialist' || speciality == 'Eye speciality' || speciality == 'Ophthalmologist' || speciality == 'ophthalmologist')
                          Expanded(child: Image.asset('assets/icons/prescriptions_optometrist.png', height: 250)),
                      ],
                 )
                    ,
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.verdigris,
                    ),
                    onPressed: () => _printPrescription(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Print',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.verdigris,
                    ),
                    onPressed: _isSubmitting ? null : _submitPrescription,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _isSubmitting
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }


  Future<Uint8List?> _capturePrescriptionImage() async {
    RenderRepaintBoundary boundary =
        _key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 5.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _generatePdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.topLeft,
                child: pw.Image(image, fit: pw.BoxFit.contain),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void _printPrescription(BuildContext context) async {
    try {
      Uint8List? imageBytes = await _capturePrescriptionImage();
      await _generatePdf(imageBytes!);
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to print!")),
      );
    }
  }

  void _submitPrescription() async {

    setState(() {
      _isSubmitting = true; // Start the submission process
    });

    try {
      // Capture the prescription as an image
      Uint8List? imageBytes = await _capturePrescriptionImage();
      if (imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to capture prescription!")),
        );
        return;
      }

      // Save the image to a temporary file
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/prescription_${widget.appointment.contact}.jpg';
      File tempFile = File(tempPath);
      await tempFile.writeAsBytes(imageBytes);

      // Upload the file using the PrescriptionProvider
      if (tempFile != null) {
        await Provider.of<PrescriptionProvider>(context, listen: false).uploadPrescription(
          widget.appointment.contact!,
          tempFile,
        );
      }


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false; // End the submission process
      });
    }
  }


}
