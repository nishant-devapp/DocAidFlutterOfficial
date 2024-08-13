import 'dart:convert';

import 'package:code/dashboard/models/add_schedule_model.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import 'package:http/http.dart' as http;

class DashboardService{

  final TokenManager _tokenManager = TokenManager();

  Future<void> addSchedule(String purpose, String location, String startDate, String endDate, String startTime, String endTime) async{

    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      const String baseUrl = AppUrls.baseUrl + ApiEndpoints.addScheduleEndpoint;

      final url = Uri.parse(baseUrl);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "purpose": purpose,
          "clinicName": location,
          "startTime": startTime,
          "endTime": endTime,
          "stDate": startDate,
          "endDate": endDate
        }),
      );

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to add clinic');
      }
    }catch(error){
      print('Error adding schedule: $error');
      throw error;
    }

  }

}