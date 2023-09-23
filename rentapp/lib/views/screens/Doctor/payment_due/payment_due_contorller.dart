import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentDueContoroller extends GetxController {
  RxList data = [].obs;

  getPayment({required Map k}) async {
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
        Uri.parse("https://udservice.shop/Api/get_pending_doctor_api.php"),
        headers: h,
        body: k);

    if (response.statusCode == 200) {
      var d = jsonDecode(response.body);
      print(d);
      data.value = d;
    }
  }
}
