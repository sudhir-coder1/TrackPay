import 'package:get/get.dart';

import '../presentation/controller/homeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(()=>HomeController());
  }
}