import 'package:count_provider_app/modle/thema_mode.dart';
import 'package:flutter/material.dart';

class ThemaProvier extends ChangeNotifier {
  ThemMode themMode = ThemMode(isDrak: false);

  void ChnageThame() {
    themMode.isDrak = !themMode.isDrak;
    notifyListeners();
  }
}
