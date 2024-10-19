import 'dart:convert';

import 'package:code/accounts/model/account_model.dart';
import 'package:code/accounts/model/subscription_amout_model.dart';
import 'package:code/accounts/model/visit_model.dart';
import 'package:code/home/models/home_get_model.dart';
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

  Future<VisitModel> countTodayVisit() async {
    print(todayDate);
    print(firstDateOfMonth);

    try {
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

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return VisitModel.fromJson(data);
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (error) {
      print('Error fetching visits: $error');
      throw error;
    }
  }

  Future<VisitModel> countThisMonthVisit() async {
    try {
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

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return VisitModel.fromJson(data);
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (error) {
      print('Error fetching visits: $error');
      throw error;
    }
  }

  Future<AmountModel> countTodayEarning() async {
    try {
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

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AmountModel.fromJson(data);
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (error) {
      print('Error fetching visits: $error');
      throw error;
    }
  }

  Future<AmountModel> countThisMonthEarning() async {
    try {
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

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AmountModel.fromJson(data);
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (error) {
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

  Future<SubscriptionAmountModel> getTotalAmount(
      int duration, numberOfClinics) async {
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

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.getSubscriptionOrderIdEndPoint;

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

  Future<RazorpayPaymentVerificationModel> getPaymentStatus(
      String paymentId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.getPaymentVerificationEndPoint;

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

  Future<bool> updateCurrentSubscriptionDetails(
      String orderId,
      String paymentId,
      String startDate,
      int duration,
      int amount,
      int doctorId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.updatingNewEndDateEndPoint;

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

  Future<bool> createPaymentHistory(
      String orderId,
      String paymentId,
      String subscriptionStartDate,
      int duration,
      int amount,
      int doctorId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.createPaymentHistoryEndPoint;

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

  Future<SubscriptionHistoryModel> fetchSubscriptionHistory(
      int doctorId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      String baseUrl =
          AppUrls.baseUrl + ApiEndpoints.fetchSubscriptionHistoryEndPoint;

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

  Future<Map<String, Map<String, double>>> fetchWeeklyGraphForAllClinics(List<ClinicDtos> clinics) async {
    Map<String, Map<String, double>> clinicIncome = {};

    String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchWeeklyGraphByClinicIdEndPoint;
    try {
      for (var clinic in clinics) {
        print(clinic.id);
        final queryParameters = {'clinicId': clinic.id.toString()};
        final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
        print("Fetching data from URL: $url");

        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];

          // Initialize the clinic entry if not exists
          if (!clinicIncome.containsKey(clinic.id)) {
            clinicIncome[clinic.id.toString()] = {
              "SUNDAY": 0.0,
              "MONDAY": 0.0,
              "TUESDAY": 0.0,
              "WEDNESDAY": 0.0,
              "THURSDAY": 0.0,
              "FRIDAY": 0.0,
              "SATURDAY": 0.0,
            };
          }

          // Add each day's income to the specific clinic
          data.forEach((day, income) {
            clinicIncome[clinic.id.toString()]![day] = income['totalAmount'] ?? 0.0;
          });
        } else {
          print("Failed to fetch data: ${response.reasonPhrase}");
        }
      }

      return clinicIncome; // Return income data per clinic

    } catch (error) {
      print('Error fetching weekly info: $error');
      throw error;
    }
  }

  Future<Map<String, Map<String, double>>> fetchYearlyGraphForAllClinics(List<ClinicDtos> clinics) async {
    Map<String, Map<String, double>> clinicIncome = {};
    var now = DateTime.now();
    String currentYear = now.year.toString();

    String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchYearlyGraphByClinicIdEndPoint;
    try {
      for (var clinic in clinics) {

        print(clinic.id);
        final queryParameters = {'year': currentYear,'clinicId': clinic.id.toString()};

        final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
        print("Fetching data from URL: $url");

        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];

          // Initialize the clinic entry if not exists
          if (!clinicIncome.containsKey(clinic.id)) {
            clinicIncome[clinic.id.toString()] = {
              "JANUARY": 0.0,
              "FEBRUARY": 0.0,
              "MARCH": 0.0,
              "APRIL": 0.0,
              "MAY": 0.0,
              "JUNE": 0.0,
              "JULY": 0.0,
              "AUGUST": 0.0,
              "SEPTEMBER": 0.0,
              "OCTOBER": 0.0,
              "NOVEMBER": 0.0,
              "DECEMBER": 0.0,
            };
          }

          // Add each day's income to the specific clinic
          data.forEach((day, income) {
            clinicIncome[clinic.id.toString()]![day] = income['totalAmount'] ?? 0.0;
          });
        } else {
          print("Failed to fetch data: ${response.reasonPhrase}");
        }
      }

      return clinicIncome; // Return income data per clinic

    } catch (error) {
      print('Error fetching weekly info: $error');
      throw error;
    }
  }

  /*Future<Map<String, Map<String, Map<String, double>>>> fetchWeeklyGraphForAllClinics(List<ClinicDtos> clinics) async {
    Map<String, Map<String, Map<String, double>>> clinicIncome = {};

    String baseUrl = AppUrls.baseUrl + ApiEndpoints.fetchWeeklyGraphByClinicIdEndPoint;
    try {
      for (var clinic in clinics) {
        print(clinic.id);
        final queryParameters = {'clinicId': clinic.id.toString()};
        final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
        print("Fetching data from URL: $url");

        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];

          // Initialize the clinic entry if it does not exist
          if (!clinicIncome.containsKey(clinic.id)) {
            clinicIncome[clinic.id.toString()] = {
              "SUNDAY": {},
              "MONDAY": {},
              "TUESDAY": {},
              "WEDNESDAY": {},
              "THURSDAY": {},
              "FRIDAY": {},
              "SATURDAY": {},
            };
          }

          // Add income and appointments data for each day
          data.forEach((day, income) {
            // print("Processing $day for clinic ID ${clinic.id}");
            double totalAmount = income['totalAmount'] ?? 0.0;
            double totalAppointments = income['totalAppointments'] ?? 0.0;

            // print("For $day: totalAmount = $totalAmount, totalAppointments = $totalAppointments");

            clinicIncome[clinic.id.toString()]![day] = {
              'totalAmount': totalAmount,
              'totalAppointments': totalAppointments,
            };
          });
        } else {
          print("Failed to fetch data: ${response.reasonPhrase}");
        }
      }

      return clinicIncome; // Return the updated data structure

    } catch (error) {
      print('Error fetching weekly info: $error');
      throw error;
    }
  }*/



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
