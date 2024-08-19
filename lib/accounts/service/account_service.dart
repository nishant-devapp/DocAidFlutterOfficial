import 'dart:convert';

import 'package:code/accounts/model/account_model.dart';
import 'package:code/accounts/model/subscription_amout_model.dart';
import 'package:code/accounts/model/visit_model.dart';
import 'package:intl/intl.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import 'package:http/http.dart' as http;

import '../model/end_date_model.dart';
import '../model/payment_verification_model.dart';
import '../model/subscription_history_model.dart';
import '../model/subscription_order_model.dart';

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

  Future<EndDateModel> getEndDate(int docId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.endDateEndPoint;

      final queryParameters = {'doctorId': docId.toString()};

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
        return EndDateModel.fromJson(data);
      } else {
        throw Exception('Failed to get endDate');
      }
    } catch (error) {
      print('Error fetching endDate: $error');
      throw error;
    }
  }

  Future<SubscriptionAmountModel> getTotalAmount(int duration, numberOfClinics) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.getTotalAmountEndPoint;

      final queryParameters = {
        'duration': duration.toString(),
        'numberOfClinics': numberOfClinics.toString()
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
        return SubscriptionAmountModel.fromJson(data);
      } else {
        throw Exception('Failed to get amount');
      }
    } catch (error) {
      print('Error fetching amount: $error');
      throw error;
    }
  }

  Future<SubscriptionOrderModel> getPaymentOrderId(int amount) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.getSubscriptionOrderIdEndPoint;

      final queryParameters = {
        'amount': amount.toString(),
      };

      final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return SubscriptionOrderModel.fromJson(data);


      } else {
        throw Exception('Failed to get orderId');
      }
    } catch (error) {
      print('Error fetching orderId: $error');
      throw error;
    }
  }

  Future<RazorpayPaymentVerificationModel> getPaymentStatus(String paymentId) async{
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.getPaymentVerificationEndPoint;

      final queryParameters = {
        'paymentId': paymentId,
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
        return RazorpayPaymentVerificationModel.fromJson(data);

      } else {
        throw Exception('Failed to get verification status');
      }
    } catch (error) {
      print('Error fetching verification status: $error');
      throw error;
    }
  }

  Future<bool> updateCurrentSubscriptionDetails(String orderId, String paymentId, String startDate, int duration, int amount, int doctorId) async{
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.updatingNewEndDateEndPoint;

      final url = Uri.parse(baseUrl);

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "orderId": orderId,
          "paymentId": paymentId,
          "startDate": startDate,
          "duration": duration,
          "amount": amount.toString(),
          "doctorId": doctorId.toString(),
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
        throw Exception('Failed to get verification status');
      }
    } catch (error) {
      return false;
      print('Error fetching verification status: $error');
      throw error;
    }
  }

  Future<bool> createPaymentHistory(String orderId, String paymentId, String subscriptionStartDate, int duration, int amount, int doctorId) async{
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.createPaymentHistoryEndPoint;

      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "orderId": orderId,
          "paymentId": paymentId,
          "subscriptionStartDate": subscriptionStartDate,
          "paymentDate": todayDate,
          "duration": duration,
          "amount": amount,
          "doctorId": doctorId
        }),
      );

      print(response.body);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
        throw Exception('Failed to get verification status');
      }
    } catch (error) {
      return false;
      print('Error fetching verification status: $error');
      throw error;
    }
  }

  Future<SubscriptionHistoryModel> fetchSubscriptionHistory(int doctorId) async{

    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchSubscriptionHistoryEndPoint;

      final queryParameters = {'doctorId': doctorId.toString()};

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
        return SubscriptionHistoryModel.fromJson(data);
      } else {
        throw Exception('Failed to get subscription history');
      }
    } catch (error) {
      print('Error fetching endDate: $error');
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