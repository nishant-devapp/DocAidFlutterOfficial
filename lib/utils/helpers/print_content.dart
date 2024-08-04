import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

enum PrintAlignment {
  topCenter,
  topLeft,
  // Add other alignments if needed
}

Future<void> printContent(GlobalKey key, PrintAlignment alignment) async {
  try {
    // Capture the content as an image
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 9.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = byteData!.buffer.asUint8List();

    // Create the PDF document
    final pdf = pw.Document();
    final imageProvider = pw.MemoryImage(imageBytes);

    // Calculate the size and position
    final pageWidth = PdfPageFormat.a4.width;
    final pageHeight = PdfPageFormat.a4.height;
    final contentWidth = image.width.toDouble();
    final contentHeight = image.height.toDouble();

    final scaledWidth = contentWidth * 0.6; // Scale factor
    final scaledHeight = contentHeight * 0.5;

    double topPosition;
    double leftPosition;

    switch (alignment) {
      case PrintAlignment.topCenter:
        topPosition = 0;
        leftPosition = (pageWidth - scaledWidth) / 2;
        break;
      case PrintAlignment.topLeft:
        topPosition = 0;
        leftPosition = 0;
        break;
    // Add more cases if needed
    }

    // Add the scaled and positioned image to the PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Positioned(
                top: topPosition,
                left: leftPosition,
                child: pw.Container(
                  width: scaledWidth,
                  height: scaledHeight,
                  child: pw.Image(imageProvider),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Print the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    // Handle exceptions
    print('Error printing content: $e');
  }
}
