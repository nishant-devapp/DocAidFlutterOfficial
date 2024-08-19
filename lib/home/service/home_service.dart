import 'dart:convert';
import 'dart:io';
import 'package:code/utils/constants/api_endpoints.dart';
import 'package:code/utils/constants/app_urls.dart';
import 'package:code/utils/helpers/TokenManager.dart';
import 'package:code/home/models/home_get_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class HomeGetService {
  final TokenManager _tokenManager = TokenManager();

  Future<HomeGetModel> fetchDoctorProfile() async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      const String baseUrl = AppUrls.baseUrl + ApiEndpoints.homeGetEndPoint;

      final url = Uri.parse(baseUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return HomeGetModel.fromJson(data);
      } else {
        throw Exception('Failed to load doctor profile');
      }
    } catch (error) {
      print('Error fetching doctor profile: $error');
      throw error;
    }
  }

  Future<Uint8List?> fetchDoctorImage() async{
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      const String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchDoctorImageEndPoint;

      final url = Uri.parse(baseUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes; // Returns Uint8List
      } else {
        throw Exception('Failed to load image');
      }

    } catch (error) {
      print('Error fetching doctor profile: $error');
      throw error;
    }
  }

  Future<void> updateDoctorImage(File imageFile) async{
    try {

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updateDoctorImageEndPoint;

      final uri = Uri.parse(baseUrl);

      final request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(
          http.MultipartFile(
            'image',
            imageFile.readAsBytes().asStream(),
            imageFile.lengthSync(),
            filename: imageFile.path.split('/').last,
          ),
        );

      final response = await request.send();

      print(response);

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Image upload successful: $responseBody');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to update image: $responseBody');
        throw Exception('Failed to upload file: $responseBody');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> addNewClinic(
      String clinicName,
      String location,
      String incharge,
      String startTime,
      String endTime,
      String clinicContact,
      String clinicNewFee,
      String clinicOldFees,
      List<String> days) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      const String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.addNewClinicEndPoint;

      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "clinicName": clinicName,
          "location": location,
          "incharge": incharge,
          "startTime": startTime,
          "endTime": endTime,
          "clinicContact": clinicContact,
          "clinicNewFees": clinicNewFee,
          "clinicOldFees": clinicOldFees,
          "days": days.map((day) => day.toUpperCase()).toList()
        }),
      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Failed to add clinic');
      }
    } catch (error) {
      print('Error adding clinic: $error');
      throw error;
    }
  }

  Future<void> updateClinic(
      int clinicId,
      String clinicName,
      String location,
      String incharge,
      String startTime,
      String endTime,
      String clinicContact,
      String clinicNewFee,
      String clinicOldFees,
      List<String> days,) async {

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = '${AppUrls.baseUrl}${ApiEndpoints.updateClinicEndPoint}/$clinicId';
      // String baseUrl = 'https://dev.doc-aid.in/main-backend-api-gateway/clinic/update/114';

      print(baseUrl);

      final url = Uri.parse(baseUrl);

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "clinicName": clinicName,
          "location": location,
          "incharge": incharge,
          "startTime": startTime,
          "endTime": endTime,
          "clinicContact": clinicContact,
          "clinicNewFees": clinicNewFee,
          "clinicOldFees": clinicOldFees,
          "days": days.map((day) => day.toUpperCase()).toList(),
        }),

      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update clinic: ${response.body}');
        throw Exception('Failed to update clinic');
      }

    }catch(error){
      print('Error updating clinic: $error');
      throw error;
    }

  }

  Future<void> updateDoctorProfile(
      String firstName,
      String lastName,
      String email,
      String contact,
      List<String> degrees,
      List<String> achievements,
      List<String> researchJournal,
      List<String> citations,
      List<String> specialization,
      int experience,
      String licenceNumber
      ) async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updateProfileEndPoint;

      print(baseUrl);

      final url = Uri.parse(baseUrl);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "contact": contact,
          "degree": degrees,
          "achievements": achievements,
          "research_journal": researchJournal,
          "citations": citations,
          "specialization": specialization,
          "experience": experience,
          "licenceNumber": licenceNumber
        }),

      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update profile: ${response.body}');
        throw Exception('Failed to update profile');
      }

    }catch(error){
      print('Error updating profile: $error');
      throw error;
    }
  }

  Future<void> addNewSchedule(String startTime, String endTime, String location, String purpose, String startDate, String endDate) async{

    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      const String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.addScheduleEndpoint;

      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "startTime": startTime,
          "endTime": endTime,
          "clinicName": location,
          "stDate": startDate,
          "endDate": endDate,
          "purpose": purpose
        }),
      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to add schedule');
      }
    } catch (error) {
      print('Error adding schedule: $error');
      throw error;
    }

  }

  Future<void> updateSchedule(int interfaceId, String startTime, String endTime, String location, String purpose, String startDate, String endDate) async{
    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updateScheduleEndpoint;

      final queryParameters = {
        'doctorInterfaceId': interfaceId.toString()
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      print(baseUrl);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "startTime": startTime,
          "endTime": endTime,
          "clinicName": location,
          "stDate": startDate,
          "endDate": endDate,
          "purpose": purpose
        }),

      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update schedule: ${response.body}');
        throw Exception('Failed to update schedule');
      }

    }catch(error){
      print('Error updating schedule: $error');
      throw error;
    }
  }

}
