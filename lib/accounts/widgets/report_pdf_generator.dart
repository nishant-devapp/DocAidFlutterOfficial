import 'package:code/accounts/service/account_service.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/widgets.dart' as pw;

class ReportPdfGenerator {
  final AccountService reportService;

  ReportPdfGenerator({required this.reportService});

  Future<pw.Document> generateReport({
    required String doctorName,
    required bool allClinics,
    required String selectedRange,
    required List<int?> clinicIds,
    required List<String?> clinicLocations,
    required int year,
    String? startDate,
    String? endDate,
  }) async {
    final pdf = pw.Document();

    for (int i = 0; i < clinicIds.length; i++) {
      final clinicId = clinicIds[i];
      final clinicLocation = clinicLocations[i];

      try {
        Map<String, dynamic> reportData;

        // Fetch data based on the selected range
        if (selectedRange == 'This Year') {
          reportData = await reportService.fetchYearlyReport(clinicId!, year);
          _buildYearlyReport(pdf, reportData, doctorName, clinicId,
              clinicLocation, allClinics);
        } else {
          // For custom range
          if (startDate == null || endDate == null) {
            throw Exception("Invalid date range for custom report");
          }
          reportData = await reportService.fetchCustomReport(
              clinicId!, startDate, endDate);
          _buildCustomReport(pdf, reportData, doctorName, clinicId,
              clinicLocation, allClinics);
        }
      } catch (e) {
        print("Error generating report for clinic ID $clinicId: $e");
        throw Exception("Failed to generate report for clinic ID $clinicId");
      }
    }

    return pdf;
  }

  Future<void> _buildYearlyReport(
      pw.Document pdf,
      Map<String, dynamic> data,
      String docName,
      int clinicId,
      String? clinicLocation,
      bool allClinics) async {
    final image = await loadImage('assets/icons/doc_aid.png');

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    // Ensure all items start-aligned
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        // Explicitly align doctor name to the left
                        child: pw.Text(
                          docName,
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.SizedBox(height: 6.0,),
                      if (allClinics)
                        pw.Text(
                          'Report for all clinics',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.normal),
                        ),
                      pw.SizedBox(height: 6.0,),
                      pw.Text(
                        "Yearly Report for location: ${clinicLocation ?? 'N/A'}",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.normal),
                      ),
                    ],
                  ),
                  pw.Image(image, height: 50.0, width: 80.0),
                ]),
            pw.SizedBox(height: 20),
            _buildTableHeaders("Month"),
            ...data.entries
                .where((entry) => entry.key != "TOTAL_SUMMARY")
                .map((entry) {
              return _buildRow(
                entry.key,
                entry.value["totalAppointments"],
                entry.value["totalAmount"],
                entry.value["cashAmount"],
                entry.value["upiAmount"],
              );
            }),
            pw.SizedBox(height: 10),
            _buildRow(
              "TOTAL",
              data["TOTAL_SUMMARY"]["totalAppointments"],
              data["TOTAL_SUMMARY"]["totalAmount"],
              data["TOTAL_SUMMARY"]["cashAmount"],
              data["TOTAL_SUMMARY"]["upiAmount"],
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  void _buildCustomReport(
      pw.Document pdf,
      Map<String, dynamic> data,
      String docName,
      int clinicId,
      String? clinicLocation,
      bool allClinics) async {
    final image = await loadImage('assets/icons/doc_aid.png');
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    // Ensure all items start-aligned
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        // Explicitly align doctor name to the left
                        child: pw.Text(
                          docName,
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      if (allClinics)
                        pw.Text(
                          'Report for all clinics',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.normal),
                        ),
                      pw.Text(
                        "Location: ${clinicLocation ?? 'N/A'}",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.normal),
                      ),
                    ],
                  ),
                  pw.Image(image, height: 50.0, width: 80.0),
                ]),
            pw.SizedBox(height: 10),
            _buildTableHeaders("Date"),
            ...data.entries.map((entry) {
              return _buildRow(
                entry.key,
                entry.value["totalAppointments"],
                entry.value["totalAmount"],
                entry.value["cashAmount"],
                entry.value["upiAmount"],
              );
            }),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildTableHeaders(String label) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: PdfColors.blue500,
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: pw.Center(
          child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
              child: pw.Text(label,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
          pw.Expanded(
              child: pw.Text("Appointments",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
          pw.Expanded(
              child: pw.Text("Total Amount",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
          pw.Expanded(
              child: pw.Text("Cash",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
          pw.Expanded(
              child: pw.Text("UPI",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white))),
        ],
      )),
    );
  }

  pw.Widget _buildRow(String date, dynamic appointments, dynamic totalAmount,
      dynamic cashAmount, dynamic upiAmount,
      {bool isBold = false}) {
    final textStyle = isBold
        ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
        : const pw.TextStyle();
    final displayDate = date == "9999-12-31"
        ? "TOTAL  :- "
        : date; // Replace 9999-12-31 with TOTAL
    return pw.Column(children: [
      pw.SizedBox(
        height: 5.0,
      ),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text(displayDate, style: textStyle)),
          pw.Expanded(
              child: pw.Text(appointments.toString(), style: textStyle)),
          pw.Expanded(child: pw.Text(totalAmount.toString(), style: textStyle)),
          pw.Expanded(child: pw.Text(cashAmount.toString(), style: textStyle)),
          pw.Expanded(child: pw.Text(upiAmount.toString(), style: textStyle)),
        ],
      ),
    ]);
  }

  Future<pw.ImageProvider> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }
}
