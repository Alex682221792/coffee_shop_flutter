import 'package:coffee_shop/resources/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/resources/values/dimens.dart';

class TextStyles {
  static TextStyle titleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: Dimens.largeFont,
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat");

  static TextStyle priceTextStyle = TextStyle(
      color: Colores.alternativeBackground,
      fontSize: Dimens.normalFont,
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat");

}
