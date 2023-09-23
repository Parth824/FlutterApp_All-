import 'dart:async';

import 'package:flutter/material.dart';

class SearchDelayFunction {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  SearchDelayFunction({this.milliseconds = 2000});

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: 2000),
      action,
    );
  }
}
