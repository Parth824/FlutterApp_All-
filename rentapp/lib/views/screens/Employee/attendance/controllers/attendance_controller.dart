import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendanceController extends GetxController {

  RxList Data = [].obs;
  

  getApiData({required Map k}) async {
    String api = "http://udservice.shop/Api/get_attendance_emp_api.php";
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response =
        await http.post(Uri.parse(api), headers: h, body: k);

    if (response.statusCode == 200) {
      var d = jsonDecode(response.body);
      print(d);
      Data.value = d;
      return d;
    }
  }
}
