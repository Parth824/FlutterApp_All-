import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CahngColorController extends GetxController {
  RxBool Chang = false.obs;

  RxList Data = [].obs;
  RxBool isloding = false.obs;

  setLoding({required bool isl}) {
    isloding.value = isl;
  }

  getApiData({required Map k}) async {
    String api = "http://udservice.shop/Api/get_check_attendanxe_api.php";
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response =
        await http.post(Uri.parse(api), headers: h, body: k);

    if (response.statusCode == 200) {
      var d = jsonDecode(response.body);
      print(d);
      Data.value = d;
    }
  }

  getChang() {
    Chang.value = !Chang.value;
  }

  addData({required Map k}) async{
    String api = "http://udservice.shop/Api/add_get_attendance_api.php";
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response =
        await http.post(Uri.parse(api), headers: h, body: k);

    if (response.statusCode == 200) {
      var d = jsonDecode(response.body);
      print(d);
    }
  }
}
