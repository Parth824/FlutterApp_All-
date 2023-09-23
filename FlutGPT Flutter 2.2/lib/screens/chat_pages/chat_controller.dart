import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_keys.dart';

class ChatController extends GetxController {
  RxBool textField = false.obs;

  onchangeTextField(bool value) {
    textField.value = value;
    update();
  }

  insertMessage({required Map k}) async{
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/insert_message_api.php"),
      body: k,
      headers: h,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
    
  }

  getMessage({required Map k}) async{
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/get_all_chat_api.php"),
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
