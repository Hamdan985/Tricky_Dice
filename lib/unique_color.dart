import 'package:flutter/material.dart';
import 'dart:math';

class UniqueColorGenerator {
  static Random random = new Random();

  static Color getColor() {
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
  }
}
