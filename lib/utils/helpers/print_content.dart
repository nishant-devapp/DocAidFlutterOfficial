import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:math' as math;

Future<void> printContent(BuildContext context, GlobalKey key, String pdfName) async {
  try {
    // Capture the content as an image
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = byteData!.buffer.asUint8List();

    // Create the PDF document
    final pdf = pw.Document();
    final imageProvider = pw.MemoryImage(imageBytes);

    // Get the width and height of the A4 size paper
    final pageWidth = PdfPageFormat.a4.width;
    final pageHeight = PdfPageFormat.a4.height;

    // Get the width and height of the content
    final contentWidth = image.width.toDouble();
    final contentHeight = image.height.toDouble();

    // Calculate the scaling factor to fit the content within the A4 size paper
    final scaleX = pageWidth / contentWidth;
    final scaleY = pageHeight / contentHeight;

    // Reduce the scaling factor to make the content smaller on the page
    final scaleW = math.min(scaleX, scaleY) * 1.0; // Adjust this factor to make the content smaller
    final scaleH = math.min(scaleX, scaleY) * 0.4; // Adjust this factor to make the content smaller

    // Calculate the adjusted content width and height after scaling
    final adjustedContentWidth = contentWidth * scaleW;
    final adjustedContentHeight = contentHeight * scaleH;

    // Calculate the offset to center the content horizontally
    final offsetX = (pageWidth - adjustedContentWidth) / 2;
    final offsetY = (pageHeight - adjustedContentHeight) / 2; // Center the content vertically

    // Add the scaled and positioned image to the PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.topCenter,
            child: pw.Image(
              imageProvider,
              width: adjustedContentWidth,
              height: adjustedContentHeight,
            ),
          );
        },
      ),
    );

    // Save the PDF
    final pdfData = await pdf.save();

    // Save PDF to file (for demonstration purposes, you can replace with your file saving logic)
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  } catch (e) {
    // Handle exceptions
    print('Error printing content: $e');
  }
}
