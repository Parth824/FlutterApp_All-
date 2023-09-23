import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/models/user_model.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  UserModel? user;

  Future<void> updateIsLoading(bool value) async {
    await Future.delayed(const Duration(milliseconds: 1));
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchUser({required BuildContext context}) async {
    NavigatorState navigatorState = Navigator.of(context);
    updateIsLoading(true);
    var response = await DioApiService.getProfile();
    updateIsLoading(false);
    if (response.runtimeType == UserModel) {
      response as UserModel;
      SharedPref.instance.shared
          .setString('userobj', jsonEncode(response.data.toJson()));
      user = response;
      notifyListeners();
    } else if (response.runtimeType == String) {
      navigatorState.pushNamedAndRemoveUntil(
          RoutePath.login, (Route<dynamic> route) => false);
      Utils.showSnackBar(context: context, message: response);
    }
  }

  Future<void> register(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    NavigatorState navigatorState = Navigator.of(context);
    updateIsLoading(true);
    var response = await DioApiService.register(body: body);
    updateIsLoading(false);
    if (response.runtimeType == UserModel) {
      response as UserModel;
      SharedPref.instance.shared.setString('token', response.token!);
      user = response;
      notifyListeners();
      navigatorState.pushNamed(RoutePath.home);
    } else if (response.runtimeType == String) {
      Utils.showSnackBar(context: context, message: response);
    }
  }

  Future<void> login(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    NavigatorState navigatorState = Navigator.of(context);
    updateIsLoading(true);
    var response = await DioApiService.login(body: body);
    updateIsLoading(false);

    if (response.runtimeType == UserModel) {
      response as UserModel;
      SharedPref.instance.shared.setString('token', response.token!);
      SharedPref.instance.shared.setInt('login_user_id', response.data.id);
      SharedPref.instance.shared
          .setString('userobj', jsonEncode(response.data.toJson()));
      user = response;

      notifyListeners();
      navigatorState.pushNamed(RoutePath.home);
    } else if (response.runtimeType == String) {
      Utils.showSnackBar(context: context, message: response);
    }
  }

  Future<void> logout({required BuildContext context}) async {
    updateIsLoading(true);
    SharedPref.instance.shared.remove('token');
    SharedPref.instance.shared.clear();
    user = null;
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePath.login, (route) => false);
    updateIsLoading(true);
    notifyListeners();
  }

  Future<void> forgetPassword(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    NavigatorState navigatorState = Navigator.of(context);
    updateIsLoading(true);
    var response = await DioApiService.forgetPassword(body: body);
    updateIsLoading(false);
    if (response.runtimeType == UserModel) {
      response as UserModel;
      SharedPref.instance.shared.setString('token', response.token!);
      user = response;
      notifyListeners();
      navigatorState.pushNamed(RoutePath.home);
    } else if (response.runtimeType == String) {
      Utils.showSnackBar(context: context, message: response);
    }
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
      if (image != null) {
        updateIsLoading(true);
        var response = await DioApiService.updateProiflePicture(file: image);
        updateIsLoading(false);
        if (response.runtimeType == UserModel) {
          user = response;
        }
      }
    } else if (sourceType == 'camera') {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        updateIsLoading(true);
        var response = await DioApiService.updateProiflePicture(file: image);
        updateIsLoading(false);
        if (response.runtimeType == UserModel) {
          user = response;
        }
      }
    }
    notifyListeners();
    print(sourceType);
  }
}
