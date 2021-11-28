import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/data/provider/database.dart';
import 'package:shop_app_task/app/modules/cart/cart_controller.dart';
import 'package:shop_app_task/app/routes/app_routes.dart';
import 'package:shop_app_task/app/widgets/item_widget/item_widget.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  CartController get cart => Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Groceries Market"),
        actions: [
          Tooltip(
            message: "Cart",
            child: TextButton.icon(
              onPressed: () => Get.toNamed(Routes.CART),
              icon: const Icon(Icons.shopping_cart_rounded),
              label: Obx(() => cart.items.isNotEmpty
                  ? Text(
                      cart.items.length.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    )
                  : const SizedBox.shrink()),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.ORDERS_HISTORY),
          icon: const Icon(Icons.history),
          tooltip: "Orders History",
        ),
      ),
      body: FutureBuilder<List<Item>>(
        future: Data.getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              controller.items.assignAll(snapshot.data!);
              return ListView.separated(
                primary: true,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];

                  return ItemWidget(item);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
