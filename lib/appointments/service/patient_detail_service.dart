import 'dart:convert';

import 'package:code/appointments/models/add_patient_response_model.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import 'package:http/http.dart' as http;
import '../../utils/helpers/TokenManager.dart';
import '../models/abha_patient_list_model.dart';
import '../models/patient_list_by_contact_model.dart';

class PatientDetailService {
  final TokenManager _tokenManager = TokenManager();

  Future<AbhaPatientDetailModel?> fetchPatientInfoByAbha(String abha) async {
    try {
      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.fetchPatientListByAbhaEndPoint;

      final queryParameters = {'abhaNumber': abha};
      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (jsonResponse['data'] != null) {
          return AbhaPatientDetailModel.fromJson(jsonResponse);
        } else {
          return null; // No patient data found
        }
      } else if (response.statusCode == 404) {
        return null; // No patient data found
      } else {
        throw Exception('Failed to load patient info: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching patient info: $error');
      throw Exception('Error fetching patient info');
    }
  }

  Future<ContactPatientDetailModel?> fetchPatientInfoByContact(
      String contact) async {
    try {
      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.fetchPatientsListByContactEndPoint;

      final queryParameters = {'contact': contact};
      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['data'] != null) {
          return ContactPatientDetailModel.fromJson(
              jsonResponse); // Parse a single object
        } else {
          return null; // No patient data found
        }
      } else if (response.statusCode == 404) {
        return null; // No patient data found
      } else {
        throw Exception('Failed to load patient info: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching patient info: $error');
      throw Exception('Error fetching patient info');
    }
  }

  Future<AddPatientResponseModel?> addNewPatient(
      String name,
      String abhaNum,
      int age,
      String contact,
      String gender,
      String guardianName,
      String address) async {
    // status 201
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.addNewPatientEndPoint;

      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        body: jsonEncode({
          "name": name,
          "abhaNumber": abhaNum,
          "age": age.toString(),
          "contact": contact,
          "gender": gender,
          "guardianName": guardianName,
          "address": address
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print(responseData);
        final addPatientResponse = AddPatientResponseModel.fromJson(responseData);
        return addPatientResponse;
      } else {
        print('Failed to add patient: ${response.body}');
        throw Exception('Failed to add patient');
      }
    } catch (error) {
      print('Error booking appointment: $error');
      throw error;
    }
  }

  Future<AddPatientResponseModel?> updatePatientInfo(
      String name,
      String abhaNum,
      int age,
      String contact,
      String gender,
      String guardianName,
      String address) async {
    // status 200
  }
}
