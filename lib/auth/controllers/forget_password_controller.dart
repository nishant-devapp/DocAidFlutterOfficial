import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dashboard/response/common_response.dart';
import '../../utils/constants/app_urls.dart';

class ForgetPasswordController {
  Future<CommonResponse?> forgetPassword(
      String email, String newPassword, String confirmPassword) async {

    final Uri url = Uri.parse("${AppUrls.baseUrl}/dashboard/forgotPassword").replace(
      queryParameters: {
        'email': email,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );

    // Making the PUT request
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return CommonResponse.fromJson(responseData);
    } else {
      return null;
    }
  }
}
