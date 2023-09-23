import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashBoardController extends GetxController {
  RxList dashBoard = [].obs;

  getData() async {
    http.Response response = await http.get(
      Uri.parse("https://udservice.shop/Api/total_doctor_employee_sales_api.php"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      dashBoard.value = data;
    }
  }
}
