import 'package:get/get.dart';
import 'package:shop_app_task/app/modules/cart/cart_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(CartController());
  }
}
