import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoryChatController extends GetxController {
  RxBool textField = false.obs;

  onchangeTextField(bool value) {
    textField.value = value;
    update();
  }

  DeleteOne({required Map k}) async {
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/delete_one_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
  }
  DeleteAll({required Map k}) async {
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/delete_all_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
  }
}
