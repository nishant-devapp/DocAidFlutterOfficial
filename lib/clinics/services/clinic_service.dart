import 'dart:convert';

import 'package:intl/intl.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import '../models/additional_clinic_model.dart';
import 'package:http/http.dart' as http;

class ClinicService{

  final TokenManager _tokenManager = TokenManager();
  final String todayDate = getTodayDate();

  Future<AdditionalClinicModel> calculateAdditionalClinicAmount(int remainingDays) async{
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.additionalClinicPaymentEndPoint;

      final queryParameters = {
        'remainingDays': remainingDays.toString(),
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
        final data = jsonDecode(response.body);
        return AdditionalClinicModel.fromJson(data);

      } else {
        throw Exception('Failed to get additional clinic charge');
      }
    } catch (error) {
      print('Error fetching additional clinic charge: $error');
      throw error;
    }
  }

}

String getTodayDate() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  return formatted;
}