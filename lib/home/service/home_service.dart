import 'dart:convert';
import 'package:code/utils/constants/api_endpoints.dart';
import 'package:code/utils/constants/app_urls.dart';
import 'package:code/utils/helpers/TokenManager.dart';
import 'package:code/home/models/home_get_model.dart';
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
      List<String> days,
      ) async {

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
}
