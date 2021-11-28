import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;

import 'item_model.dart';

class Order {
  final int? id;
  final List<Item> items;
  final String createdAt;

  Order({
    this.id,
    required this.items,
    required this.createdAt,
  });

  String get dateFormatted =>
      intl.DateFormat.yMMMEd().format(DateTime.parse(createdAt));
  String get timeFormatted =>
      intl.DateFormat("h:m a").format(DateTime.parse(createdAt));

  Order copyWith({
    int? id,
    List<Item>? items,
    String? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Order(id: $id, items: $items, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        listEquals(other.items, items) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ items.hashCode ^ createdAt.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'items': json.encode(items.map((x) => x.toJson()).toList()),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? 0,
      items: List<Item>.from(
          json.decode(map['items'])?.map((x) => Item.fromJson(x)) ?? const []),
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
