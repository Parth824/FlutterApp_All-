// import 'dart:core';
//
// import 'package:dio/dio.dart';
// import 'package:school_vahan/strings.dart';
//
// class Distance_Matrix_API {
//   // Distance_Matrix_API(
//   //     this.userlat, this.userlong, this.driverlat, this.driverlong);
//   static Future<List<String>> getTime(double? userlat, double? userlong,
//       double? driverlat, double? driverlong) async {
//     try {
//       Dio dio = new Dio();
//       String api =
//           '${Strings.distance_matrix_url}origins=${driverlat},${driverlong}&destinations=${userlat},${userlong}&key=${Strings.distance_matrix_api_key}';
//       print("API $api");
//       Response response = await dio.get(api);
//       List<dynamic> elements = response.data["rows"];
//       print(elements);
//       String distance = elements[0]["elements"][0]["distance"]["text"];
//       String time = elements[0]["elements"][0]["duration"]["text"];
//       print(distance);
//       print(time);
//       List<String> list = [distance, time];
//       return list;
//     } catch (e) {
//       print(e);
//       return Future.error(e);
//     }
//   }
// }
