import 'dart:convert';

import 'package:code/home/models/HomeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/app_urls.dart';
import '../../utils/helpers/TokenManager.dart';
import '../models/home_get_model.dart';
import '../service/HomeGetService.dart';

class HomeProvider with ChangeNotifier {
//   HomeGetModel? _homeGetModel;
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   HomeGetModel? get homeGet => _homeGetModel;
//
//   bool get loading => _isLoading;
//
//   String get errorMessage => _errorMessage;
//
//   Future<void> fetchDoctorDetail() async {
//     String? token = await TokenManager().getToken();
//     if (token == null) {
//       _errorMessage = 'No token found';
//       notifyListeners();
//       return;
//     }
//
//     const url = '${AppUrls.baseUrl}/home/get';
//     final headers = {
//       'Authorization': 'Bearer $token',
//     };
//
//     try {
//       _isLoading = true;
//       _errorMessage = '';
//       notifyListeners();
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _homeGetModel = HomeGetModel.fromJson(data);
//         print(response);
//       } else {
//         _errorMessage =
//         'Failed to load data. Status code: ${response.statusCode}';
//       }
//     } catch (error) {
//       _errorMessage = 'Failed to load data. Error: $error';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
}


// class HomeProvider with ChangeNotifier{
//
//   late HomeGetModel data;
//
//   bool loading = false;
//   HomeGetService services = HomeGetService();
//
//   getPostData(context) async {
//     loading = true;
//     data = await services.getData(context);
//     loading = false;
//
//     notifyListeners();
//   }
//
// }
