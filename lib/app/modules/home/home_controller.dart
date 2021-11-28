import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/data/provider/database.dart';

class HomeController extends GetxController {
  final items = <Item>[].obs;

  @override
  void onReady() {
    Data.getItems();
    super.onReady();
  }
}
