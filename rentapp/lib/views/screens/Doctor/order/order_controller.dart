import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  RxList Data = [].obs;
  RxList Data1 = [].obs;
  RxInt currenIndex = 0.obs;

  setIndex({required int k}) {
    currenIndex.value = k;
  }

  getData({required Map k}) async {
    http.Response response = await http
        .get(Uri.parse("https://udservice.shop/Api/add_get_product_api.php"));

    String api = "https://udservice.shop/Api/get_doctor_id_api.php";

    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response1 =
        await http.post(Uri.parse(api), headers: h, body: k);

    if (response.statusCode == 200) {
      var rd = jsonDecode(response.body);
      print(rd);
      Data.value = rd;
    }
    if (response1.statusCode == 200) {
      var rd = jsonDecode(response1.body);
      print(rd);
      Data1.value = rd;
      return rd;
    }
  }
}
