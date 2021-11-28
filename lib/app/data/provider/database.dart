import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/data/model/order_model.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  Data._();

  static Future<Database> getDatabase() async {
    var db = await openDatabase('orders.db');

    await db.execute(
      "CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY, createdAt TEXT, items TEXT)",
    );

    return db;
  }

  static Future<List<Item>> getItems() async {
    try {
      // loads string from local classes.csv file
      final String classes = await rootBundle.loadString("assets/classes.csv");

      // splits lines and convert to list of strings
      final List<String> lines = const LineSplitter().convert(classes);
      lines.removeAt(0);

      var items = <Item>[];

      for (var line in lines) {
        var data = line.split(",");

        // final String desc = await rootBundle.loadString("assets" + data[5]);

        var item = Item(
          name: data[0],
          id: data[1],
          typeName: data[2],
          typeId: data[3],
          imagePath: data[4],
          // description: desc,
          price: double.parse(data[6]),
        );

        items.add(item);
      }

      items.shuffle();
      return items;
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> checkout(List<Item> items) async {
    var db = await getDatabase();

    Order order = Order(items: items, createdAt: DateTime.now().toString());

    try {
      await db.insert(
        "orders",
        order.toMap(),
      );

      var query = await db.query(
        "orders",
        where: "createdAt='${order.createdAt}'",
      );

      if (query.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<Order>> getAllOrders() async {
    var db = await getDatabase();

    List<Map<String, dynamic>> maps = await db.query("orders");

    return maps.map((e) => Order.fromMap(e)).toList();
  }

  static Future<void> clearOrders() async {
    var db = await getDatabase();

    await db.execute(
      "DROP TABLE IF EXISTS orders",
    );
  }
}
