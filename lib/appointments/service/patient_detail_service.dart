import 'dart:convert';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import 'package:http/http.dart' as http;
import '../models/abha_patient_list_model.dart';
import '../models/patient_list_by_contact_model.dart';

class PatientDetailService{

  Future<AbhaPatientDetailModel?> fetchPatientInfoByAbha(String abha) async {
    try {
      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchPatientListByAbhaEndPoint;

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

 Future<ContactPatientDetailModel?> fetchPatientInfoByContact(String contact) async {
    try {
      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchPatientsListByContactEndPoint;

      final queryParameters = {'contact': contact};
      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          return ContactPatientDetailModel.fromJson(jsonResponse['data']); // Parse a single object
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


/*Future<List<Data>> fetchPatientInfoByContact(String contact) async{

    try{

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.patientInfoByContactEndPoint;

      final queryParameters = {
        'contact': contact,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic>? dataJson = jsonResponse['data']; // Allow dataJson to be null
        return dataJson?.map((item) => Data.fromJson(item)).toList() ?? [];
      } else if (response.statusCode == 404) {
        return []; // Return an empty list if no data found
      }else {
        throw Exception('Failed to load patient info');
      }

    }catch(error){
      print('Error fetching patient info: $error');
      throw error;
    }

  }*/

}