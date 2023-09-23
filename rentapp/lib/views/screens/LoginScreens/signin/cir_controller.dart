import 'package:get/get.dart';

class CirController extends GetxController {
  RxBool isloding = false.obs;

  setLoding({required bool isl}) {
    isloding.value = isl;
  }
}
