import 'package:flutter/services.dart';

class PdfSaver {
  static const MethodChannel _channel = MethodChannel('pdf_saving_channel');

  static Future<String?> savePdfToDownloads(Uint8List pdfData, String fileName) async {
    try {
      final String? result = await _channel.invokeMethod('saveToDownloads', {
        'data': pdfData,
        'fileName': fileName,
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to save PDF: ${e.message}");
      return null;
    }
  }
}
