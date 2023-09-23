import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LedgerContorller extends GetxController {
  RxList Data = [].obs;
  RxInt debit = 0.obs;
  RxInt credit = 0.obs;

  getApiData({required Map k}) async {
    String api = "http://udservice.shop/Api/get_doctor_all_api_id.php";
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

  getAmount({required int k, required String py}) {
    if (py == "Receiving") {
      credit.value = credit.value + k;
    } else {
      debit.value = debit.value + k;
    }
  }
}
