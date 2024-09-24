import 'dart:convert';

import 'package:code/appointments/models/payment_info_model.dart';
import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import '../models/fetch_appointment_model.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  final TokenManager _tokenManager = TokenManager();

  Future<AppointmentList> fetchAllAppointments(String date) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.fetchAllAppointmentsEndPoint;

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

      print(response.body);

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

  Future<AppointmentList> fetchClinicAppointments(
      int clinicId, String date) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.fetchClinicAppointmentEndPoint;

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
    } catch (error) {
      print('Error fetching appointments: $error');
      throw error;
    }
  }

  Future<void> updateAppointmentInfo(
      int appointmentId,
      String name,
      String abha,
      int age,
      String contact,
      String address,
      String guardianName,
      String gender,
      String appointmentDate,
      String appointmentTime,
      String clinicLocation) async {
    try {
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
        body: jsonEncode({
          "name": name,
          "abhaNumber": abha,
          "age": age,
          "contact": contact,
          "gender": gender,
          "appointmentDate": appointmentDate,
          "appointmentTime": appointmentTime,
          "clinicLocation": clinicLocation,
          "address": address,
          "guardianName": guardianName
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to update appointment: ${response.body}');
        throw Exception('Failed to update appointment');
      }
    } catch (error) {
      print('Error updating appointment: $error');
      throw error;
    }
  }

  Future<bool> deleteAppointment(int appointmentId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          "${AppUrls.baseUrl}${ApiEndpoints.deleteAppointmentEndPoint}/$appointmentId";

      final url = Uri.parse(baseUrl);

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<void> addNewAppointment(
      int clinicId,
      String name,
      String abha,
      String age,
      String contact,
      String address,
      String guardianName,
      String gender,
      String appointmentDate,
      String appointmentTime,
      String paymentStatus,
      String clinicLocation) async {
    try {
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
        body: jsonEncode({
          "name": name,
          "abhaNumber": abha,
          "age": age,
          "contact": contact,
          "address": address,
          "guardianName": guardianName,
          "gender": gender,
          "appointmentDate": appointmentDate,
          "appointmentTime": appointmentTime,
          "paymentStatus": paymentStatus,
          "clinicLocation": clinicLocation
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to book appointment: ${response.body}');
        throw Exception('Failed to book appointment');
      }
    } catch (error) {
      print('Error booking appointment: $error');
      throw error;
    }
  }

  Future<void> changeVisitStatus(int appointmentId, bool isVisited) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.updateAppointmentVisitStatusEndPoint;

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
    } catch (error) {
      print('Error updating visit status: $error');
      throw error;
    }
  }

  Future<void> unpayAppointment(int appointmentId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          '${AppUrls.baseUrl}${ApiEndpoints.unpayAppointmentEndPoint}/$appointmentId';

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
    } catch (error) {
      print('Error updating payment status: $error');
      throw error;
    }
  }

  Future<void> createAppointmentPayment(
      int appointmentId, String modeOfPayment, String amount, String appointmentDate, int clinicId, int doctorId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          '${AppUrls.baseUrl}${ApiEndpoints.createAppointmentPaymentEndPoint}/$appointmentId';
      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({"modeOfPayment": modeOfPayment, "amount": amount, "appointmentDate": appointmentDate, "clinicId": clinicId, "doctorId": doctorId}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to make payment: ${response.body}');
        throw Exception('Failed to make payment');
      }
    } catch (error) {
      print('Error updating payment status: $error');
      throw error;
    }
  }

  Future<PaymentInfoModel> getAppointmentPayment(int appointmentId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          '${AppUrls.baseUrl}${ApiEndpoints.getAppointmentPaymentEndPoint}/$appointmentId';
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
        return PaymentInfoModel.fromJson(data);
        print(data);
      } else {
        print('Failed to fetch payment info: ${response.body}');
        throw Exception('Failed to fetch payment info');
      }
    } catch (error) {
      print('Error fetching payment info: $error');
      throw error;
    }
  }

  Future<void> updateAppointmentPayment(
      int appointmentId, String modeOfPayment, String amount) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          '${AppUrls.baseUrl}${ApiEndpoints.updateAppointmentPaymentEndPoint}/$appointmentId';
      final url = Uri.parse(baseUrl);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({"modeOfPayment": modeOfPayment, "amount": amount}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to make payment: ${response.body}');
        throw Exception('Failed to update payment');
      }
    } catch (error) {
      print('Error updating payment status: $error');
      throw error;
    }
  }

  Future<Map<String, int>> fetchCalendarAppointmentCount(
      int doctorId, String startDate, String endDate) async {
    try {
      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.calendarAppointmentCountEndPoint;

      final queryParameters = {
        'doctorId': doctorId.toString(),
        'startDate': startDate,
        'endDate': endDate,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        print('Fetched Data: $data'); // Add this line to verify fetched data
        return data.map((key, value) => MapEntry(key, value as int));
      } else {
        throw Exception('Failed to load appointment counts');
      }
    } catch (error) {
      print('Error booking appointment: $error');
      throw error;
    }
  }

  Future<Map<String, int>> fetchClinicWiseAppointmentCount(String localDate) async{
    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.clinicWiseAppointmentCountEndPoint;

      final queryParameters = {
        'localDate': localDate
      };

     final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }
        );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        print('Fetched Data: $data'); // Add this line to verify fetched data
        return data.map((key, value) => MapEntry(key, value as int));
      } else {
        throw Exception('Failed to load appointment counts');
      }

    }
    catch (error) {
    print('Error fetching clinic appointment: $error');
    throw error;
    }
  }

}
