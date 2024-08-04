import 'dart:convert';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import 'package:http/http.dart' as http;
import '../models/patient_info_by_abha_phone_model.dart';

class PatientDetailService{

  Future<List<Data>> fetchPatientInfoByAbha(String abha) async{

    try{

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.patientInfoByAbhaEndPoint;

      final queryParameters = {
        'abhaNumber': abha,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic>? dataJson = jsonResponse['data']; // Allow dataJson to be null
        return dataJson?.map((item) => Data.fromJson(item)).toList() ?? [];
      } else if (response.statusCode == 404) {
        return []; // Return an empty list if no data found
      }
      else {
        throw Exception('Failed to load patient info');
      }

    }catch(error){
      print('Error fetching patient info: $error');
      throw error;
    }

  }

  Future<List<Data>> fetchPatientInfoByContact(String contact) async{

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

  }

}