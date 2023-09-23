import 'dart:convert';

import 'package:chat_gpt/utils/app_keys.dart';
import 'package:http/http.dart' as http;





class ChatGptApi {



    getImageFromChatGpt(String message,{required String? size}) async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            "Authorization": "Bearer $openAiToken",
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"prompt": message,"size" : size,"n": 1,}));
      return jsonDecode(response. body)["data"][0]["url"] as String;
    } catch (e) {
      print("Error  is  -----> $e");
      return "";
    }
  }


     Future<String> getChatResponse(String message) async {
     String endpoint = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

     Map<String, String> headers = {
       'Authorization': 'Bearer $openAiToken',
       'Content-Type': 'application/json',
     };

     Map<String, dynamic> body = {
       'prompt': message,
       'max_tokens': 50,
     };

     var response = await http.post(Uri.parse(endpoint), headers: headers, body: jsonEncode(body));

     if (response.statusCode == 200) {
       var data = jsonDecode(response.body);
       String chatResponse = data['choices'][0]['text'];
       print("chatResponse -=-------> $chatResponse");
       return chatResponse;
     } else {
       print(response.statusCode);
       print(response.body);
       throw Exception('Failed to get chat response');
     }
   }


}