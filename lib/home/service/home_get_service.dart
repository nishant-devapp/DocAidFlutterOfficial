import 'dart:convert';
import 'package:code/utils/constants/app_urls.dart';
import 'package:code/utils/helpers/TokenManager.dart';
import 'package:code/home/models/home_get_model.dart';
import 'package:http/http.dart' as http;

class HomeGetService {
  final TokenManager _tokenManager = TokenManager();
  static const String baseUrl = "${AppUrls.baseUrl}/home/get";

  Future<HomeGetModel> fetchDoctorProfile() async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

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
}