import 'package:get/get.dart';

class Select_Cat_Controller extends GetxController{

  RxBool isDoctor = true.obs;

  void updateIsDoctor({required bool k}){
    isDoctor.value = k;
  }

}