import 'dart:convert';

import 'package:code/accounts/model/account_model.dart';
import 'package:code/accounts/model/visit_model.dart';
import 'package:intl/intl.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import 'package:http/http.dart' as http;

class AccountService {

  final TokenManager _tokenManager = TokenManager();
  final String todayDate = getTodayDate();
  final String firstDateOfMonth = getFirstDayOfCurrentMonth();

  Future<VisitModel> countTodayVisit() async{

    print(todayDate);
    print(firstDateOfMonth);

    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.totalVisitEndPoint;

      final queryParameters = {
        'startDate': todayDate,
        'endDate': todayDate,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return VisitModel.fromJson(data);
      }else{
        throw Exception('Failed to load visits');
      }

    }catch(error){
      print('Error fetching visits: $error');
      throw error;
    }

  }

  Future<VisitModel> countThisMonthVisit() async{

    try{
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.totalVisitEndPoint;

      final queryParameters = {
        'startDate': firstDateOfMonth,
        'endDate': todayDate,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return VisitModel.fromJson(data);
      }else{
        throw Exception('Failed to load visits');
      }

    }catch(error){
      print('Error fetching visits: $error');
      throw error;
    }

  }

  Future<AmountModel> countTodayEarning() async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.totalEarningEndPoint;

      final queryParameters = {
        'startDate': todayDate,
        'endDate': todayDate,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return AmountModel.fromJson(data);
      }else{
        throw Exception('Failed to load visits');
      }

    }catch(error){
      print('Error fetching visits: $error');
      throw error;
    }

  }

  Future<AmountModel> countThisMonthEarning() async{

    try{

      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.totalEarningEndPoint;

      final queryParameters = {
        'startDate': firstDateOfMonth,
        'endDate': todayDate,
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return AmountModel.fromJson(data);
      }else{
        throw Exception('Failed to load visits');
      }

    }catch(error){
      print('Error fetching visits: $error');
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

String getFirstDayOfCurrentMonth() {
  final DateTime now = DateTime.now();
  final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(firstDayOfMonth);
  return formatted;
}