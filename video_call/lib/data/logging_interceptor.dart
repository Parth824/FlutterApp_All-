import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('*** API Request - Start ***');
    printKV('URI', options.uri);
    printKV('METHOD', options.method);
    log('HEADERS:');
    options.headers.forEach((key, v) => printKV(' - $key', v));
    log('BODY:');
    printAll(options.data ?? "");

    log('*** API Request - End ***');
    String? accessToken = SharedPref.instance.shared.getString('token');
    if (accessToken == null) {
      log('trying to send request without token exist!');
      return super.onRequest(options, handler);
    }
    options.headers["Authorization"] = "Bearer $accessToken";
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log('*** Api Error - Start ***:');

    log('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      log('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    log('$err');
    if (err.response != null) {
      printKV('REDIRECT', err.response?.realUri ?? '');
      log('BODY:');
      printAll(err.response?.toString());
      if (err.response != null) {
        var errMsg = jsonDecode(err.response.toString());
        if (errMsg != null) {
          if (errMsg['message'] == 'Unauthenticated.') {
            Utils.logout();
          }
        }
      }
    }

    log('*** Api Error - End ***:');
    super.onError(err, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('*** Api Response - Start ***');

    printKV('URI', response.requestOptions.uri);
    printKV('STATUS CODE', response.statusCode ?? 0000);
    printKV('REDIRECT', response.isRedirect ?? false);
    log('BODY:');
    printAll(response.data ?? "");

    log('*** Api Response - End ***');

    super.onResponse(response, handler);
  }

  void printKV(String key, Object v) {
    log('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(log);
  }

  void log(String s) {
    debugPrint(s);
  }
}
