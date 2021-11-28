import 'package:get/get.dart';

import 'view_product_controller.dart';


class ViewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ViewProductController());
  }
}
