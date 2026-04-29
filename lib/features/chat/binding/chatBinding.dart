import 'package:cashkaro/features/chat/presentation/controller/chatController.dart';
import 'package:get/get.dart';

import '../../addPayment/presentation/controller/paymentController.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ChatController());
    // Get.lazyPut(()=>PaymentController());
  }
}