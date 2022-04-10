import 'package:coffee_shop/resources/values/colors.dart';
import 'package:flutter/material.dart';


class Gradients {

  static LinearGradient brownGradient = LinearGradient(
      begin: AlignmentDirectional.topCenter,
      end: AlignmentDirectional.bottomCenter,
       stops: const [0.25, 1.0],
      colors: [Colores.primaryBackground, Colores.primaryBackground.withAlpha(0)]);
}
