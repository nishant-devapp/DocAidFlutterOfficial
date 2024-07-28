import 'dart:convert';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import '../models/fetch_appointment_model.dart';
import 'package:http/http.dart' as http;

class AppointmentService{

  final TokenManager _tokenManager = TokenManager();

  Future<AppointmentList> fetchAllAppointments(String date) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchAllAppointmentsEndPoint;

      final queryParameters = {
        'startDate': date,
        'endDate': date,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return AppointmentList.fromJson(data);
      } else {
        print('Failed to load appointments: ${response.body}');
        throw Exception('Failed to load appointments');
      }
    } catch (error) {
      print('Error fetching appointments: $error');
      throw error;
    }
  }

  Future<AppointmentList> fetchClinicAppointments(int clinicId, String date) async {
    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchClinicAppointmentEndPoint;

      final queryParameters = {
        'clinicId': clinicId.toString(),
        'startDate': date,
        'endDate': date,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AppointmentList.fromJson(data);
      } else {
        print(response.statusCode);
        throw Exception('Failed to load appointments');
      }


    }catch(error){
      print('Error fetching appointments: $error');
      throw error;
    }
  }

  Future<void> unpayAppointment(int appointmentId) async{

    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = '${AppUrls.baseUrl}${ApiEndpoints.unpayAppointmentEndPoint}/$appointmentId';

      final url = Uri.parse(baseUrl);

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

      } else {
        print('Failed to unpay appointment: ${response.body}');
        throw Exception('Failed to unpay appointment');
      }

    }catch(error){
      print('Error updating payment status: $error');
      throw error;
    }


  }

  Future<void> changeVisitStatus(int appointmentId, bool isVisited) async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updateAppointmentVisitStatusEndPoint;

      final queryParameters = {
        'appintmentId': appointmentId.toString(),
        'checked': isVisited.toString(),
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update visit status: ${response.body}');
        throw Exception('Failed to update visit status');
      }

    }catch(error){
      print('Error updating visit status: $error');
      throw error;
    }

  }

  Future<void> updateAppointmentInfo(int appointmentId, String name, String abha, int age, String contact, String gender, String appointmentDate, String appointmentTime, String clinicLocation) async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updateAppointmentEndPoint;

      final queryParameters = {
        'id': appointmentId.toString(),
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: {
          "name": name,
          "abhaNumber": abha,
          "age": age.toString(),
          "contact": contact,
          "gender": gender,
          "appointmentDate": appointmentDate,
          "appointmentTime": appointmentTime,
          "clinicLocation": clinicLocation
        }
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update appointment: ${response.body}');
        throw Exception('Failed to update appointment');
      }


    }catch(error){
      print('Error updating appointment: $error');
      throw error;
    }

  }

  Future<void> addNewAppointment(int clinicId, String name, String abha, int age, String contact, String gender, String appointmentDate, String appointmentTime, String paymentStatus, String clinicLocation) async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.bookAppointmentEndPoint;

      final queryParameters = {
        'clinicId': clinicId.toString(),
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: {
            "name": name,
            "abhaNumber": abha,
            "age": age.toString(),
            "contact": contact,
            "gender": gender,
            "appointmentDate": appointmentDate,
            "appointmentTime": appointmentTime,
            "paymentStatus": paymentStatus,
            "clinicLocation": clinicLocation
          }
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to book appointment: ${response.body}');
        throw Exception('Failed to book appointment');
      }

    }catch(error){
      print('Error booking appointment: $error');
      throw error;
    }

  }

}