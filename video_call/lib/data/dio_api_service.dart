import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videocall_app/models/call_history_model.dart';
import 'package:videocall_app/models/chat_model.dart';
import 'package:videocall_app/models/recent_chat_model.dart';
import 'package:videocall_app/models/search_user_model.dart';
import 'package:videocall_app/models/user_model.dart';
import 'package:videocall_app/utils/constants/api_path.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/router/router_path.dart';

class DioApiService {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: "https://ilal.app/admin/public/index.php/api",
  );
  static final Dio dio = Dio(_baseOptions);

  static Future generateAgoraToken(
      {required String uid, required String channel}) async {
    try {
      Dio _dio2 = Dio();
      var response = await _dio2
          .get('${AppConfig.chat_soket_url}/token?uid=$uid&channel=$channel');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future register({required Map<String, dynamic> body}) async {
    try {
      final Response response = await dio.post(ApiPath.register, data: body);
      if (response.data['success'] == true) {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
    }
  }

  static Future login({required Map<String, dynamic> body}) async {
    try {
      final Response response = await dio.post(ApiPath.login, data: body);

      if (response.data['success'] == '1') {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      return 'something went wrong';
    }
  }

  static Future updateProiflePicture({required XFile file}) async {
    try {
      FormData formData = FormData.fromMap({
        "profile_image": await MultipartFile.fromFile(
          file.path,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg',
        )
      });
      final Response response =
          await dio.post(ApiPath.update_profile_pic, data: formData);
      if (response.data['success'] == true) {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
    }
  }

  static Future getProfile() async {
    try {
      final Response response = await dio.get(ApiPath.get_user);
      if (response.data['success'] == true && response.data['data'] != null) {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
    }
  }

  static Future forgetPassword({required Map<String, dynamic> body}) async {
    try {
      final Response response =
          await dio.post(ApiPath.forget_password, data: body);
      if (response.data['success'] == true) {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
    }
  }

  static Future updateUserFcmToken({required String token}) async {
    try {
      Map<String, dynamic> body = {'fcm_token': token};

      String url = ApiPath.update_profile;
      var response = await dio.post(url, data: body);
      User.fromJson(response.data['data']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future searchUser({required String term}) async {
    try {
      String url = '${ApiPath.search_user}?q=$term';
      final Response response = await dio.get(url);
      if (response.data != null) {
        if (response.data['data'] != null) {
          SearchUserModel searchUserModel =
              SearchUserModel.fromJson(response.data);
          return searchUserModel;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future listAllChat() async {
    try {
      String url = ApiPath.list_all_chat;
      final Response response = await dio.get(url);
      if (response.data != null) {
        if (response.data['data'] != null) {
          RecentChatList recentChatList =
              RecentChatList.fromJson(response.data);
          return recentChatList;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future getPersonalChat(String receiverId, String chatType) async {
    try {
      String url =
          '${ApiPath.list_personal_chat}?id=${receiverId.toString()}&type=$chatType';
      final Response response = await dio.get(url);
      if (response.data != null) {
        if (response.data['success'] == true) {
          ChatModel chatModel = ChatModel.fromJson(response.data);
          return chatModel;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future deleteChat(String id) async {
    try {
      String url = "${ApiPath.delete_chat}/$id/delete";
      final Response response = await dio.delete(url);
    } catch (e) {
      print(e);
    }
  }

  static Future sendMessage(String? message, XFile? file, XFile? audio,
      String receiverUserId, String type) async {
    FormData formData;
    if (file != null) {
      String fileName = file.path.split('/').last;
      if (fileName.contains(".mp4")) {
        Map<String, dynamic> _b = {};
        if (type == 'group') {
          _b.addAll({
            'receiver_group_id': receiverUserId,
            "video": await MultipartFile.fromFile(file.path, filename: fileName)
          });
        } else {
          _b.addAll({
            'receiver_user_id': receiverUserId,
            "video": await MultipartFile.fromFile(file.path, filename: fileName)
          });
        }
        formData = FormData.fromMap(_b);
      } else {
        Map<String, dynamic> _b = {};

        if (type == 'group') {
          _b.addAll({
            'receiver_group_id': receiverUserId,
            "image": await MultipartFile.fromFile(file.path, filename: fileName)
          });
        } else {
          _b.addAll({
            'receiver_user_id': receiverUserId,
            "image": await MultipartFile.fromFile(file.path, filename: fileName)
          });
        }
        formData = FormData.fromMap(_b);
      }
    } else if (audio != null) {
      String fileName = audio.path.split('/').last;
      formData = FormData.fromMap({
        "receiver_user_id": receiverUserId,
        "audio": await MultipartFile.fromFile(audio.path, filename: fileName)
      });
    } else {
      Map<String, dynamic> _b = {};

      if (type == 'group') {
        _b.addAll({
          'text': message,
          'receiver_group_id': receiverUserId,
        });
      } else {
        _b.addAll({
          'text': message,
          'receiver_user_id': receiverUserId,
        });
      }
      formData = FormData.fromMap(_b);
    }
    try {
      String url = ApiPath.send_message;
      final Response response = await dio.post(url, data: formData);

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future sendMessageWithMedia(String keyName, String path,
      String fileName, String receiverUserId, String type) async {
    if (keyName.isEmpty) {
      return false;
    }
    //keyName = image, audio, video, document
    Map<String, dynamic> _b = {};
    if (type == 'group') {
      _b.addAll({
        'receiver_group_id': receiverUserId,
        keyName: await MultipartFile.fromFile(path, filename: fileName)
      });
    } else {
      _b.addAll({
        'receiver_user_id': receiverUserId,
        keyName: await MultipartFile.fromFile(path, filename: fileName)
      });
    }
    FormData formData = FormData.fromMap(_b);

    try {
      String url = ApiPath.send_message;
      final Response response = await dio.post(url, data: formData);

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future createGroup(BuildContext context, FormData formData) async {
    try {
      NavigatorState navigatorState = Navigator.of(context);
      String url = ApiPath.create_group;
      final Response response = await dio.post(url, data: formData);
      if (response.data != null) {
        if (response.data['success'] == true) {
          navigatorState.pushNamedAndRemoveUntil(
              RoutePath.home, (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future updateGroup(
      BuildContext context, FormData formData, String groupId) async {
    try {
      NavigatorState navigatorState = Navigator.of(context);
      String url = "${ApiPath.update_group}/$groupId/update";
      final Response response = await dio.post(url, data: formData);
      if (response.data != null) {
        if (response.data['success'] == true) {
          navigatorState.pushNamedAndRemoveUntil(
              RoutePath.home, (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future removeGroupMember(
      {required String groupId, required String userId}) async {
    try {
      String url =
          "${ApiPath.remove_group_member}/$groupId/remove?user_ids=$userId";
      final Response response = await dio.delete(url);

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future addGroupMember(Map<String, dynamic> body) async {
    try {
      String url = ApiPath.add_group_member;
      final Response response = await dio.post(url, data: body);
      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future addCallHistory(Map<String, dynamic> body) async {
    try {
      String url = ApiPath.postcallHistory;
      final Response response = await dio.post(url, data: body);

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future getCallHistory(String userId, String search) async {
    try {
      String url = '${ApiPath.getcallHistory}?user_id=$userId';
      if (search.isNotEmpty) {
        url += "&search=$search";
      }
      final Response response = await dio.get(url);
      debugPrint("getCallHistory: ${response.data}");

      if (response.data != null) {
        if (response.data['success'] == true) {
          CallHistoryModel callModel = CallHistoryModel.fromJson(response.data);
          return callModel;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
