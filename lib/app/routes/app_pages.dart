import 'package:get/get.dart';
import 'package:shop_app_task/app/modules/cart/cart_binding.dart';
import 'package:shop_app_task/app/modules/cart/cart_page.dart';
import 'package:shop_app_task/app/modules/home/home_binding.dart';
import 'package:shop_app_task/app/modules/home/home_page.dart';
import 'package:shop_app_task/app/modules/orders_history/orders_history_binding.dart';
import 'package:shop_app_task/app/modules/orders_history/orders_history_page.dart';

import 'app_routes.dart';

class AppPages {
  static const String INIT_ROUTE = Routes.HOME;

  static List<GetPage> get pages => [
        GetPage(
          name: Routes.HOME,
          page: () => const HomePage(),
          binding: HomeBinding(),
          transition: Transition.topLevel,
        ),
        GetPage(
          name: Routes.CART,
          page: () => const CartPage(),
          binding: CartBinding(),
        ),
        GetPage(
          name: Routes.ORDERS_HISTORY,
          page: () => const OrdersHistoryPage(),
          binding: OrdersHistoryBinding(),
        ),
      ];
}
