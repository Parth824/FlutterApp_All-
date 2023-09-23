import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/message_model.dart';
import '../screens/chat_pages/chat_controller.dart';

class SharedPrefsUtils {
  static storeOnBoarding(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHomeScreen', value);
  }

  static Future<void> storeChat(
      {required String chat,
      required bool sentByMe,
      required String dateTime,
      required String answer}) async {
    ChatController chatController = Get.put(ChatController());
    String prefsKey = DateTime.now().microsecondsSinceEpoch.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await chatController.insertMessage(k: {
      'message': chat,
      'sentByme': '$sentByMe',
      'dateTime': dateTime,
      'U_Id': prefs.getString('id'),
      'mId': prefsKey,
      'answer': answer,
    });
    MessageModel messageModel = MessageModel(
        message: chat,
        sentByMe: sentByMe,
        id: prefsKey,
        dateTime: dateTime,
        answer: answer);

    String jsonDocument = json.encode(messageModel);
    await prefs.setString(prefsKey.toString(), jsonDocument);
  }

  static Future<void> getChat() async {
    historyList.clear();
    ChatController chatController = Get.put(ChatController());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    

    List jsonDocument =
        await chatController.getMessage(k: {'U_Id': prefs.getString('id')});

    jsonDocument.forEach((element) {
      MessageModel messageModel = MessageModel(
          message: element['message'],
          sentByMe: (element['sentByMe'] == '1')?true:false,
          id: element['mId'],
          dateTime: element['dateTime'],
          answer: element['answer'],
        );
        historyList.add(messageModel);
    });

  }

  static Future<void> removeChat(String? nameRemove) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(nameRemove!);

    print("Remove  ID  IS   =====> ${nameRemove.length}");
  }
}
