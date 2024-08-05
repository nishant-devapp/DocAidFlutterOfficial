import 'dart:convert';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import 'package:http/http.dart' as http;

class HelpService{

  Future<bool> sendHelpMessage(String firstName, String lastName, String email, String phone, String message) async{

    try{

      String baseUrl = AppUrls.helpBaseUrl + ApiEndpoints.sendHelpMsgEndPoint;

      final queryParameters = {
        'firstName': firstName,
        'lastName': lastName,
        'emailFrom': email,
        'phoneNumber': phone,
        'content': message,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return true;
      } else {
        print('Failed to send message: ${response.body}');
        return false;
      }


    }catch(error){
      print('Error sending message: $error');
      return false;
    }

  }

}