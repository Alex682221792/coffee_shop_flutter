import 'dart:convert';
import 'dart:math';

import 'package:coffee_shop/models/coffee.dart';
import 'package:flutter/services.dart';

class CoffeeUtils {
   final _names = [
  ];
   final random = Random();

  double _generatePrice(num start, num end) {
    return random.nextDouble() * (end - start) + start;
  }

   Future<List<Coffee>> getListCoffee() async {
     String data = await rootBundle.loadString('assets/json/data.json');
     List jsonResult = json.decode(data);
     List<Coffee> result = jsonResult.map((coffeeJson) => Coffee.fromJson(coffeeJson)).toList();
     return result;
   }
}