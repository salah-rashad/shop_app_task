import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/utils/helpers.dart';
import 'package:shop_app_task/app/widgets/item_widget/item_widget.dart';

import 'cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Text(
                    "(${controller.items.length})",
                    style: const TextStyle(fontSize: 18.0),
                  )),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.items.isEmpty
                  ? Center(child: Text("- Empty -".toUpperCase()))
                  : ListView.builder(
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        return Card(
                          child: ItemWidget(item, isCart: true),
                        );
                      },
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Summary".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Order:",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Obx(
                      () => Text(
                        currencyFormatter.format(controller.getTotalPrice),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery:",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Obx(
                      () => Text(
                        (controller.getDeliveryCost != null)
                            ? currencyFormatter
                                .format(controller.getDeliveryCost)
                            : "FREE",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        currencyFormatter.format(controller.getTotalPrice +
                            (controller.getDeliveryCost ?? 0.0)),
                        style: const TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Obx(() => ElevatedButton(
                      onPressed: controller.items.isEmpty
                          ? null
                          : () => controller.checkout(),
                      child: Text(
                        "Checkout".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60.0),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
