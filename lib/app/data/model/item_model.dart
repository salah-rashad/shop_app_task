import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Item {
  final String id;
  final String name;
  final String typeName;
  final String typeId;
  final String imagePath;
  final String? description;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.typeName,
    required this.typeId,
    required this.imagePath,
    this.description,
    required this.price,
  });

  final _count = 0.obs;
  int get count => _count.value;
  set count(int value) => _count.value = value;

  void decrease() {
    if (count <= 1) return;
    count--;
  }

  void increase() {
    if (count >= 999) return;
    count++;
  }

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      typeName: map['typeName'] ?? '',
      typeId: map['typeId'] ?? '',
      imagePath: map['imagePath'] ?? '',
      description: map['description'],
      price: map['price'] ?? 0.0,
    )..count = map['count'] ?? 0;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        typeName.hashCode ^
        typeId.hashCode ^
        imagePath.hashCode ^
        description.hashCode ^
        price.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.typeName == typeName &&
        other.typeId == typeId &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.price == price;
  }

  Item copyWith({
    String? id,
    String? name,
    String? typeName,
    String? typeId,
    String? imagePath,
    String? description,
    double? price,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      typeId: typeId ?? this.typeId,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'typeName': typeName,
      'typeId': typeId,
      'imagePath': imagePath,
      'description': description,
      'price': price,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, typeName: $typeName, typeId: $typeId, imagePath: $imagePath, description: $description, price: $price)';
  }
}
