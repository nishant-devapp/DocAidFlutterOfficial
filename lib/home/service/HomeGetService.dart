// import 'dart:convert';
//
// import 'package:code/home/models/HomeModel.dart';
//
// import 'package:http/http.dart' as http;
//
// import '../../utils/constants/app_urls.dart';
// import '../../utils/helpers/TokenManager.dart';
//
// class HomeGetService{
//   Future<HomeGetModel> getData(context) async {
//     late HomeGetModel data;
//
//     String? token = await TokenManager().getToken();
//
//       try {
//       const url = '${AppUrls.baseUrl}/home/get';
//       final headers = {
//         'Authorization': 'Bearer $token',
//       };
//
//       final response = await http.get(
//         Uri.parse(url),
//       );
//       if (response.statusCode == 200) {
//         final item = json.decode(response.body);
//         data = HomeGetModel.fromJson(item);// Mapping json response to our data model
//       } else {
//         print('Error Occurred');
//       }
//     } catch (e) {
//       print('Error Occurred'+e.toString());
//     }
//     return data;
//   }
// }