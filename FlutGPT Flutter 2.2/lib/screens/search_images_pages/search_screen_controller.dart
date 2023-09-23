import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:chat_gpt/modals/all_modal.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/open_ai_api.dart';
import '../../utils/app_keys.dart';

class SearchImageScreenController extends GetxController {
  TextEditingController imageSearch = TextEditingController();
  RxBool isLoading = false.obs;
  RxList imageList = <String>[].obs;

  int limit = Random().nextInt(50);

  insertImage({required Map k}) async {
    String api = "https://unextenuated-flower.000webhostapp.com/chatGpt/Api/add_image_api.php";

    http.MultipartRequest request =
        await http.MultipartRequest("POST", Uri.parse(api));
    print("Parth");
    request.fields['U_Id'] = k['U_Id'];

    request.files.add(http.MultipartFile.fromBytes("image", k['Image'],
        filename: k['ImageName']));

    http.StreamedResponse res = await request.send();

    print("Parth");
    if (res.statusCode == 200) {
      print("Parth");
    }
  }

  RxList imageSizeList = [
    "256x256",
    "512x512",
    "1024x1024",
  ].obs;

  RxString size = "256x256".obs;

  late OpenAI openAI;

  onImageSizeChange(index) {
    size.value = index!;
    update();
  }

  generateImage() async {
    if (imageSearch.text != "") {
      isLoading.value = true;
      imageList.clear();
      update();
      // if(imageList.length == 1){
      //   isLoading.value = false;
      //   update();
      // }

      for (int i = 0; i < imageGenerateLimit; i++) {
        update();
        String data = await ChatGptApi()
            .getImageFromChatGpt(imageSearch.text, size: size.value);
        imageList.add(data);
        data = "";
        print('imageList length ------> ${imageList.length}');
        imageList.length >= 0
            ? isLoading.value = false
            : isLoading.value = true;
        update();
      }
      isLoading.value = false;
      update();
    }
  }
}
