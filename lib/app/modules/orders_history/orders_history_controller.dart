import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/data/provider/database.dart';

class OrdersHistoryController extends GetxController {
  double getTotalPrice(List<Item> items) {
    double total = 0.0;
    for (var item in items) {
      total += (item.price * item.count);
    }
    return total;
  }

  Future<void> clearHistory() async {
    await Data.clearOrders();

    Get.back();
    Get.rawSnackbar(message: "Orders history cleared successfully.");
  }
}
