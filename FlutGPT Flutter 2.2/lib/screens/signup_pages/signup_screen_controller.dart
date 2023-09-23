import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SingupController extends GetxController {
  RxBool isLoading = false.obs;

  InsertUser({required Map k}) async {
    isLoading.value = true;
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/insert_user_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      isLoading.value = false;
      return data;
    }
    
  }
}
