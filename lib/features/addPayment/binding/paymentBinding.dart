import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../presentation/controller/paymentController.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<PaymentController>(()=>PaymentController());
  }
}