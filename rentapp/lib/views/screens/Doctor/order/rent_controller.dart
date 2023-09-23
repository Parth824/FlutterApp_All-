import 'package:get/get.dart';

class RentController extends GetxController {
  RxInt Paper = 300.obs;
  RxInt reat = 0.obs;
  RxInt MRP = 0.obs;
  RxInt ink = 0.obs;
  RxInt jally = 0.obs;
  RxInt flims = 0.obs;
  RxList Ink = [].obs;
  RxList Jally = [].obs;
  RxList X_raw = [].obs;

  setreat({required int k}) {
    reat.value = 0;
    reat.value = Paper.value * k;
    MRP.value = k;
  }

  setInk({required String k}) {
    if (Ink.contains(k)) {
      Ink.remove(k);
      reat.value -= ink.value;
    } else {
      Ink.add(k);
      reat.value += ink.value;
    }
  }

  setJayy({required String k}) {
    if (Jally.contains(k)) {
      Jally.remove(k);
      reat.value -= jally.value;
    } else {
      reat.value += jally.value;
      Jally.add(k);
      
    }
  }

  setXraw({required String k}) {
    if (X_raw.contains(k)) {
      reat.value -= flims.value;
      X_raw.remove(k);
    } else {
      reat.value += flims.value;
      X_raw.add(k);
      
    }
  }

  addPaper() {
    Paper.value += 1;
    reat.value = Paper.value * MRP.value;
  }

  subPaper() {
    if (Paper.value > 300) {
      Paper.value -= 1;
      reat.value = Paper.value * MRP.value;
    }
  }
}
