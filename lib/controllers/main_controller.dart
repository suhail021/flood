import 'package:google/controllers/home_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    if (currentIndex.value == 0 && index != 0) {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().unfocusSearch();
      }
    }
    currentIndex.value = index;
  }
}
