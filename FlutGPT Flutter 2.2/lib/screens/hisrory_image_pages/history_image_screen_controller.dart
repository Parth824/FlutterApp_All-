import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoryImageController extends GetxController {
  RxList Data = [].obs;
  DeleteOne({required Map k}) async {
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/delect_image_one_api.php"),
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
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/delete_image_all_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
  }

  getImage({required Map k}) async {
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/get_image_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      Data.value = data;
      return data;
    }
  }
}
