import 'package:count_provider_app/modle/counter.dart';
import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  Counter counter1 = Counter(counter: 0);

  void add() {
    counter1.counter++;
    notifyListeners();
  }
}