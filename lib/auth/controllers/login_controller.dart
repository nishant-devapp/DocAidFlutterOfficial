import 'dart:convert';

import 'package:code/utils/helpers/TokenManager.dart';
import 'package:code/utils/constants/app_urls.dart';
import 'package:http/http.dart' as http;

import '../response/login_response_model.dart';

class LoginController {
  Future<LoginResponse?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppUrls.baseUrl}/authenticate"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return LoginResponse.fromJson(responseData);
    } else {
      return null;
    }
  }

  Future<void> storeToken(String token) async {
    await TokenManager().saveToken(token);
  }

}
