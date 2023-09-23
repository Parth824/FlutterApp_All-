import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/models/chat_model.dart';
import 'package:videocall_app/models/recent_chat_model.dart';
import 'package:videocall_app/models/search_user_model.dart';
import 'package:videocall_app/models/user_model.dart';
import 'package:videocall_app/utils/data_type_extension.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/widgets/image_source_widget.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  bool isSearching = false;
  List<int> newGroupList = [];
  List<SearchUser> searchUserList = [];
  List<RecentDatum>? recentChat;
  ChatModel? currentChat;
  XFile? image;
  XFile? newGroupProfile;
  Function(int type)? scrollList;

  List<String> imageExt = ['jpg', 'jpeg', 'png'];
  List<String> audioExt = ['mp3', 'wav', 'wma', 'acc', 'm4a'];
  List<String> videoExt = ['mov', 'mp4', 'wmv', 'flv', 'avi', 'webm', 'mkv'];
  List<String> docExt = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt'];

  void deleteChat(int index) {
    DioApiService.deleteChat(recentChat![index].id.toString());
    recentChat?.removeAt(index);
    notifyListeners();
  }

  void clearRecentChat() {
    recentChat = null;
    notifyListeners();
  }

  Future<void> updateIsLoading(bool value) async {
    await Future.delayed(const Duration(milliseconds: 1));
    isLoading = value;
    notifyListeners();
  }

  void updateIsSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  void clearFileVar() {
    newGroupProfile = null;
    newGroupList = [];
    notifyListeners();
  }

  void clearSearchResult() {
    searchUserList.clear();
    notifyListeners();
  }

  void addUserToNewGroupList(int id) {
    if (newGroupList.contains(id)) {
      newGroupList.removeWhere((e) => e == id);
    } else {
      newGroupList.add(id);
    }
    notifyListeners();
  }

  Future searchUser(String e) async {
    searchUserList.clear();
    var response = await DioApiService.searchUser(term: e.toLowerCase());
    if (response.runtimeType == SearchUserModel) {
      response as SearchUserModel;
      searchUserList = response.data.data;
      notifyListeners();
    }
  }

  Future<void> listAllChat() async {
    var response = await DioApiService.listAllChat();
    if (response.runtimeType == RecentChatList) {
      response as RecentChatList;
      recentChat = response.data;
      notifyListeners();
    }
  }

  void clearCurrentChat() {
    currentChat = null;
    notifyListeners();
  }

  Future<void> getPersonalChat(String receiverId, String chatType) async {
    var response = await DioApiService.getPersonalChat(receiverId, chatType);
    if (response.runtimeType == ChatModel) {
      response as ChatModel;
      response.chats.sort(
        (Chat a, Chat b) => a.createdAt.compareTo(b.createdAt),
      );
      currentChat = response;
      scrollList?.call(1);
      notifyListeners();
    }
  }

  Future<void> updateNewgroupPicture({required BuildContext context}) async {
    final ImagePicker _picker = ImagePicker();
    dynamic sourceType = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'gallery');
                },
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.browse_gallery_outlined),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'camera');
                },
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera),
                      Text('Camera'),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );

    if (sourceType == 'gallery') {
      final XFile? _image =
          await _picker.pickImage(source: ImageSource.gallery);
      if (_image != null) {
        newGroupProfile = _image;
      }
    } else if (sourceType == 'camera') {
      final XFile? _image = await _picker.pickImage(source: ImageSource.camera);
      if (_image != null) {
        newGroupProfile = _image;
      }
    }
    notifyListeners();
  }

  Future<void> updateProfilePicture({required BuildContext context}) async {
    final ImagePicker _picker = ImagePicker();
    dynamic sourceType = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'gallery');
                },
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.browse_gallery_outlined),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'camera');
                },
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera),
                      Text('Camera'),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );

    if (sourceType == 'gallery') {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {}
    } else if (sourceType == 'camera') {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {}
    }
    notifyListeners();
  }

  void sendMessage(
      String receiverId, String senderID, String message, String type) async {
    Map<String, dynamic> body = {
      "receiver_user_id": int.parse(receiverId),
      "text": message
    };
    dynamic response =
        await DioApiService.sendMessage(message, null, null, receiverId, type);
    if (response == true) {
      body.addAll({
        "id": 1,
        "sender_user_id": int.parse(senderID),
        "text": null,
        "image": null,
        "audio": null,
        "video": null,
        "document": null,
        "is_read": true,
        "created_at": "2023-01-28T07:39:54.000000Z"
      });

      Utils.chatPushStream.add(body);
      await getPersonalChat(receiverId, type);
    }
  }

  void selectImage(
      BuildContext context, String receiverUserId, String type) async {
    dynamic pickedImageSource = await imageSourcePicker(context);

    if (pickedImageSource == false) {
      // XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      // if (pickedFile != null) {
      //   image = pickedFile;
      //   sendImage(image!, receiverUserId, context, type);
      // }
      List<String> fileExt = [];
      fileExt.addAll(imageExt);
      fileExt.addAll(audioExt);
      fileExt.addAll(videoExt);
      fileExt.addAll(docExt);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: fileExt,
      );
      if (result != null) {
        if (result.files.single.path != null) {
          image = XFile(result.files.single.path!);
          debugPrint(
              "result.files__: ${result.files.single.identifier!.split("/").last}");
          sendImage(result.files.single.path!,
              result.files.single.identifier ?? "", receiverUserId, type);
        } else {}
      }
    } else if (pickedImageSource == true) {
      ImagePicker picker = ImagePicker();
      XFile? pickedFile =
          await picker.pickImage(source: ImageSource.camera, maxHeight: 200);
      if (pickedFile != null) {
        image = pickedFile;
        sendImage(image!.path, "png", receiverUserId, type);
      }
    }
    notifyListeners();
  }

  void sendImage(
      String path, String ext, String receiverUserId, String type) async {
    updateIsLoading(true);

    String fileName = path.split('/').last;
    //keyName = image, audio, video, document
    String keyName = "";
    String extName = fileName;

    if (extName.contains(".")) {
      extName = extName.split(".").last;
    } else {
      extName = ext.split("/").last;
    }

    if (extName.contains(".")) {
      extName = extName.split(".").last;
    }
    if (imageExt.contains(extName)) {
      keyName = "image";
    } else if (audioExt.contains(extName)) {
      keyName = "audio";
    } else if (videoExt.contains(extName)) {
      keyName = "video";
    } else if (docExt.contains(extName)) {
      keyName = "document";
    }
    if (keyName.isEmpty) {
      if (extName.contains("image")) {
        keyName = "image";
      } else if (extName.contains("audio")) {
        keyName = "audio";
      } else if (extName.contains("video")) {
        keyName = "video";
      } else if (extName.contains("doc")) {
        keyName = "document";
      }
    }

    debugPrint("fileName $fileName, extName: $extName, keyName: $keyName");

    //keyName, path, fileName, receiverUserId, type
    try {
      var response = await DioApiService.sendMessageWithMedia(
          keyName, path, fileName, receiverUserId, type);
      if (response) {
        await getPersonalChat(receiverUserId, type);
        updateIsLoading(false);
      }
      updateIsLoading(false);
    } catch (e) {
      print(e);
      updateIsLoading(false);
    }
  }

  void createGroup(
      {required BuildContext context,
      required String name,
      required String description,
      XFile? file,
      required String members}) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "description": description,
      "image": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last)
          : null,
      "members": members,
    });
    updateIsLoading(true);
    var response = await DioApiService.createGroup(context, formData);
    updateIsLoading(false);
  }

  void updateGroup(
      {required BuildContext context,
      required String name,
      required String description,
      XFile? file,
      required String groupID}) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "description": description,
      "image": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last)
          : null,
    });
    updateIsLoading(true);
    var response = await DioApiService.updateGroup(context, formData, groupID);
    updateIsLoading(false);
  }

  Future romoveGroupMember(
      {required String groupId, required String userId}) async {
    updateIsLoading(true);

    var response =
        await DioApiService.removeGroupMember(groupId: groupId, userId: userId);
    updateIsLoading(false);

    return response;
  }

  Future addMemberToGroup({required String groupId}) async {
    String users = newGroupList.join(',');
    Map<String, dynamic> body = {
      "group_id": groupId,
      "user_ids": users,
    };
    updateIsLoading(true);
    dynamic response = await DioApiService.addGroupMember(body);
    updateIsLoading(false);

    return response;
  }
}
