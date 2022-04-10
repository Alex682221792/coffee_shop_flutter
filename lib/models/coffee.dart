import 'dart:ffi';

import 'package:meta/meta.dart';

class Coffee {
  final String name;
  final String imageUrl;
  final double price;

  Coffee({
    required this.name,
    required this.imageUrl,
    required this.price
  });

  factory Coffee.fromJson(dynamic json) {
    return Coffee(name: json['name'] as String, imageUrl: json['imageUrl'] as String, price: json['price'] as double);
  }

}