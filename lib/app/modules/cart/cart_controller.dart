import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/data/provider/database.dart';
import 'package:shop_app_task/app/routes/app_routes.dart';
import 'package:shop_app_task/app/theme/color_theme.dart';

class CartController extends GetxController {
  final items = <Item>[].obs;

  double get getTotalCount {
    double total = 0.0;
    for (var item in items) {
      total += item.count;
    }
    return total;
  }

  double get getTotalPrice {
    double total = 0.0;
    for (var item in items) {
      total += (item.price * item.count);
    }
    return total;
  }

  double? get getDeliveryCost {
    if (items.isEmpty) return 0.0;
    if (getTotalPrice > 1200.0) return null;
    return min(max(20, getTotalCount * 2), 60.0).roundToDouble();
  }

  Future<void> checkout() async {
    if (items.isEmpty) return;
    final result = await Data.checkout(items);
    if (result) {
      Get.until((route) => Get.currentRoute == Routes.HOME);
      Get.rawSnackbar(
        message: "Order sent successfully!",
        icon: const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
        ),
        mainButton: TextButton(
          onPressed: () => Get.toNamed(Routes.ORDERS_HISTORY),
          child: Text(
            "Review".toUpperCase(),
          ),
          style: TextButton.styleFrom(primary: Palette.primary),
        ),
      );
    }
    print(result);
  }
}
