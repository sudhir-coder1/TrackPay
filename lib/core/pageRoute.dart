import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../features/addPayment/binding/paymentBinding.dart';
import '../features/addPayment/presentation/screens/addPayment.dart';
import '../features/chat/binding/chatBinding.dart';
import '../features/chat/presentation/screens/chatScreen.dart';
import '../features/home/binding/homeBinding.dart';
import '../features/home/presentation/screens/homeScreen.dart';

class AppPages {
  static const home = "/";
  static const chat = "/chat";
  static const payment = "/payment";

  static List<GetPage> page = [
    GetPage(
      name: home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: chat,
      page: () => ChatScreen(),
      transition: Transition.rightToLeft,
      binding: PaymentBinding(),
    ),
    GetPage(
      name: payment,
      page: () => AddPayment(),
      transition: Transition.rightToLeft,
      binding: PaymentBinding()
    ),
  ];
}
