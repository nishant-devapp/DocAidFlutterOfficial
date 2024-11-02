import 'dart:io';

import 'package:code/accounts/service/account_service.dart';
import 'package:code/accounts/widgets/report_pdf_generator.dart';
import 'package:code/home/provider/home_provider.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../home/models/home_get_model.dart';
import '../../utils/constants/colors.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomReportDialog extends StatefulWidget {
  const CustomReportDialog({super.key});

  @override
  State<CustomReportDialog> createState() => _CustomReportDialogState();
}

class _CustomReportDialogState extends State<CustomReportDialog> {
  String _selectedRange = "This Month";
  String? year, finalStartDate, finalEndDate, _selectedClinicLocation;
  String firstDayOfMonth = AccountService().firstDateOfMonth;
  String lastDayOfMonth = AccountService().lastDateOfMonth;
  String currentYear = AccountService().currentYear.toString();
  DateTime? _startDate, _endDate;
  int? _selectedClinicId;
  ClinicDtos? selectedClinic;
  bool allClinicsSelected = true;
  bool _isStartDateValid = true;
  bool _isEndDateValid = true;
  final pdfGenerator = ReportPdfGenerator(reportService: AccountService());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final clinics = homeProvider.getAllClinics();
      final firstName = homeProvider.doctorProfile?.data!.firstName!;
      final lastName = homeProvider.doctorProfile?.data!.lastName!;
      final doctorName = "$firstName $lastName";
      final clinicsWithAll = [null, ...clinics];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Form(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Download Custom Report',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.princetonOrange, size: 25.0),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Select Clinic',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                )),
            const SizedBox(
              height: 2.0,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<ClinicDtos?>(
                hint: const Text('Select Clinic'),
                value: _selectedClinicId == null
                    ? null
                    : clinics
                        .firstWhere((clinic) => clinic.id == _selectedClinicId),
                onChanged: (ClinicDtos? newValue) {
                  setState(() {
                    selectedClinic = newValue;
                    _selectedClinicId = newValue?.id;
                    _selectedClinicLocation = newValue?.location;
                    // print(_selectedClinicId);
                    allClinicsSelected = newValue == null;
                  });
                },
                isExpanded: true,
                // This allows the dropdown to use the full width
                items: clinicsWithAll
                    .map<DropdownMenuItem<ClinicDtos?>>((ClinicDtos? clinic) {
                  return DropdownMenuItem<ClinicDtos?>(
                    value: clinic,
                    child: Text(clinic?.location ?? 'All Clinics'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Select Range',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                )),
            const SizedBox(
              height: 2.0,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedRange,
                isExpanded: true,
                items: <String>["This Month", "This Year", "Custom"]
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? newValue) async {
                  setState(() {
                    _selectedRange = newValue!;
                  });
                  // Show date picker if "Custom" is selected
                },
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            if (_selectedRange == "Custom")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _isStartDateValid
                                ? AppColors.verdigris
                                : Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            _startDate == null
                                ? 'Start Date'
                                : DateFormat('yyyy-MM-dd').format(_startDate!),
                            style: TextStyle(fontSize: deviceHeight * 0.018),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: deviceWidth * 0.04),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _isEndDateValid
                                  ? AppColors.verdigris
                                  : Colors.red),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            _endDate == null
                                ? 'End Date'
                                : DateFormat('yyyy-MM-dd').format(_endDate!),
                            style: TextStyle(fontSize: deviceHeight * 0.018),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            // below is the download button
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await requestStoragePermission();
                if (!await Permission.storage.isGranted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Storage permission denied")),
                  );
                  return;
                }

                if (_selectedRange == 'Custom' &&
                    (_startDate == null || _endDate == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please select a valid date range")),
                  );
                  return;
                }

                if (_startDate != null) {
                  finalStartDate = DateFormat('yyyy-MM-dd').format(_startDate!);
                }
                if (_endDate != null) {
                  finalEndDate = DateFormat('yyyy-MM-dd').format(_endDate!);
                }

                final clinicIds = allClinicsSelected
                    ? homeProvider
                        .getAllClinics()
                        .map((clinic) => clinic.id)
                        .toList()
                    : [_selectedClinicId!];
                final clinicLocations = allClinicsSelected
                    ? homeProvider
                        .getAllClinics()
                        .map((clinic) => clinic.location)
                        .toList()
                    : [_selectedClinicLocation!];

                // Show progress indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text("Generating report..."),
                          ],
                        ),
                      ),
                    );
                  },
                );

                try {
                  final pdf = await pdfGenerator.generateReport(
                    doctorName: doctorName,
                    allClinics: allClinicsSelected,
                    selectedRange: _selectedRange,
                    clinicIds: clinicIds,
                    clinicLocations: clinicLocations,
                    year: int.parse(currentYear),
                    startDate: finalStartDate ?? firstDayOfMonth,
                    endDate: finalEndDate ?? lastDayOfMonth,
                  );

                  final filePath = await savePdfToDownloads(pdf);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("PDF saved to Downloads: $filePath")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  print("Failed to generate or save PDF: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to download report")),
                  );
                }
                // code for downloading report
              },
              icon: const Icon(
                Icons.file_download,
                color: Colors.white,
                size: 20.0,
              ),
              label: const Text(
                "Download Report",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 2.0,
                backgroundColor: AppColors.vermilion,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            )
          ],
        )),
      );
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (pickedDate != null &&
        pickedDate != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<String?> savePdfToDownloads(pw.Document pdf) async {
    try {
      // Open a directory picker and allow the user to choose where to save the file
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        // Prepare the file path with the chosen directory and a file name
        final filePath =
            '$selectedDirectory/report_${DateTime.now().toIso8601String()}.pdf';
        final file = File(filePath);

        // Write the PDF bytes to the file
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to Downloads: $filePath");

        return filePath;
      } else {
        print("User did not select a directory.");
        return null;
      }
    } catch (e) {
      print("Error saving PDF: $e");
      return null;
    }
  }

// Future<String?> savePdfToDownloads(pw.Document pdf) async {
//   final downloadsPath = await ExternalPath.getExternalStoragePublicDirectory(
//     ExternalPath.DIRECTORY_DOCUMENTS,
//   );
//   final filePath = '$downloadsPath/report_${DateTime.now().toIso8601String()}.pdf';
//
//   final file = File(filePath);
//
//   await file.writeAsBytes(await pdf.save());
//   print("PDF saved to Downloads: $filePath");
//   return filePath;
// }
}
