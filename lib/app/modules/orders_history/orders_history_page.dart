import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/order_model.dart';
import 'package:shop_app_task/app/data/provider/database.dart';
import 'package:shop_app_task/app/modules/orders_history/orders_history_controller.dart';
import 'package:shop_app_task/app/theme/color_theme.dart';
import 'package:shop_app_task/app/utils/helpers.dart';

class OrdersHistoryPage extends GetView<OrdersHistoryController> {
  const OrdersHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Order>>(
        future: Data.getAllOrders(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            } else if (snapshot.hasData) {
              final orders = snapshot.data!;
              return DefaultTabController(
                length: orders.length,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text("Orders History"),
                    actions: [
                      IconButton(
                        onPressed:
                            orders.isNotEmpty ? controller.clearHistory : null,
                        icon: const Icon(Icons.delete_forever_rounded),
                        tooltip: "Clear History",
                      )
                    ],
                    bottom: orders.isNotEmpty
                        ? PreferredSize(
                            preferredSize:
                                const Size.fromHeight(kToolbarHeight),
                            child: TabBar(
                              isScrollable: true,
                              indicatorColor: Palette.onPrimary,
                              tabs: orders.reversed
                                  .map((order) => Tab(
                                        text: order.dateFormatted +
                                            "\n" +
                                            order.timeFormatted,
                                      ))
                                  .toList(),
                            ),
                          )
                        : null,
                  ),
                  body: orders.isNotEmpty
                      ? TabBarView(
                          children: orders.reversed
                              .map((order) => Column(
                                    children: [
                                      Expanded(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: order.items.length,
                                          itemBuilder: (context, index) {
                                            final item = order.items[index];
                                            return ListTile(
                                              title: Text(item.name),
                                              subtitle: Text(currencyFormatter
                                                  .format(item.price)),
                                              leading: Image.asset(
                                                  "assets" + item.imagePath),
                                              trailing:
                                                  Text(item.count.toString()),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                "Total:",
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                currencyFormatter.format(
                                                    (controller.getTotalPrice(
                                                        order.items))),
                                                style: const TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        )
                      : Center(
                          child: Text("- Empty -".toUpperCase()),
                        ),
                ),
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
