import 'package:count_provider_app/modle/fv.dart';
import 'package:flutter/material.dart';

class FvProvider extends ChangeNotifier {
  FV f = FV(sub: []);

  void add({required int a}) {
    f.sub.add(a);
    notifyListeners();
  }

  void remove({required int a}) {
    f.sub.remove(a);
    notifyListeners();
  }
}
