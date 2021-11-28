import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/modules/home/home_binding.dart';
import 'package:shop_app_task/app/routes/app_pages.dart';
import 'package:shop_app_task/app/theme/app_theme.dart';

  void main() {
  runApp(const GroceriesMarket());
}

class GroceriesMarket extends StatelessWidget {
  const GroceriesMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Groceries Market",
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      initialRoute: AppPages.INIT_ROUTE,
      getPages: AppPages.pages,
      theme: AppTheme.light,
    );
  }
}
