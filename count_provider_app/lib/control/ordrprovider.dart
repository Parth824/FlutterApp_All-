import 'package:count_provider_app/modle/reor.dart';
import 'package:flutter/material.dart';

class ReOdProvider extends ChangeNotifier {
  ReOd r = ReOd(
    data: ['A', 'B', 'C', 'D', 'E', 'F'],
  );

  get re => r.data;

  del(var k) {
    k = r.data.removeAt(k);
    notifyListeners();
    return k;
  }

  void insert(var k,var l) {
    r.data.insert(k, l);
    notifyListeners();
  }
}
