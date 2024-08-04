import 'dart:convert';
import 'dart:io';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class PrescriptionService{

  Future<List<Uint8List>> fetchPrescription(String phoneNumber) async{

    try{

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchPrescriptionEndPoint;

      final queryParameters = {
        'contact': phoneNumber,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      // Print the constructed URL for debugging
      print('Fetching prescriptions from URL: $url');

      final response = await http.get(url);

      // Print the status code and response body for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        List<String> data = List<String>.from(decodedResponse['data']);
        return data.map((base64String) => base64.decode(base64String)).toList();
      } else {
        print('Failed to load prescriptions: ${response.body}');
        throw Exception('Failed to load prescriptions');
      }

    }catch(error){
      print('Error fetching appointments: $error');
      throw error;
    }

  }

  Future<bool> uploadPrescription(String phoneNumber, File file) async{
    try {
      String baseUrl = AppUrls.baseUrl + ApiEndpoints.uploadPrescriptionEndPoint;

      final uri = Uri.parse(baseUrl);

      final request = http.MultipartRequest('POST', uri);
      request.fields['contact'] = phoneNumber;

      final mimeType = lookupMimeType(file.path)!.split('/');
      final fileType = mimeType[0];
      final fileSubType = mimeType[1];

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        file.path,
        contentType: MediaType(fileType, fileSubType),
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseString);
        return jsonResponse['statusCode'] == 200;
      } else {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }

}