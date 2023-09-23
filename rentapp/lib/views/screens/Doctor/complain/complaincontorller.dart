import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ComplainContoroller extends GetxController {
  setComplain({required Map k}) async {
    String api = "https://udservice.shop/Api/add_get_complain_api.php";

    http.MultipartRequest request =
        await http.MultipartRequest("POST", Uri.parse(api));

    request.fields['D_Id'] = k['D_Id'];
    request.fields['E_Id'] = k['E_Id'];
    request.fields['Printer_Name'] = k['Printer_Name'];
    request.fields['Description'] = k['Description'];

    request.files.add(http.MultipartFile.fromBytes("Image", k['Image'],
        filename: k['ImageName']));
    request.files.add(http.MultipartFile.fromBytes(
        "Nozel_Check", k['Nozel_Check'],
        filename: k['NozelName']));

    http.StreamedResponse res = await request.send();
    if (res.statusCode == 200) {
      print("Parth");
    }
  }
}
