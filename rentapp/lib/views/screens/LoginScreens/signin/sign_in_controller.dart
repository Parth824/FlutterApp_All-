import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as htp;

class SingInController extends GetxController {
  RxMap data = {}.obs;
  Future<void> getDoctor(
      {required bool isDoctor, required String Email}) async {
    String doc = "get_doctor_e_p_api.php";
    String em = "get_employee_e_p_api.php";

    Map<String, String> k = {'Email': Email};
    Map<String, String> h = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    htp.Response response = await htp.post(
        Uri.parse("https://udservice.shop/Api/${(isDoctor) ? doc : em}"),
        headers: h,
        body: k);
    if (response.statusCode == 200) {
      var data1 = await jsonDecode(response.body);
      print(data1);
      if (data1 == null) {
        data.value = {};
      } else {
        data.value = data1;
      }
    }
  }
}
