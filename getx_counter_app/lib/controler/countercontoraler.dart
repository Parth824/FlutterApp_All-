import 'package:get/get.dart';
import 'package:getx_counter_app/modles/countermodle.dart';

class CounterControler extends GetxController {
  CounterModle count = CounterModle(c: 0);

  void add() {
    count.c++;
    
    update();
  }
}
