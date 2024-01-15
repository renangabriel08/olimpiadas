import 'package:flutter/material.dart';
import 'package:modulo03/styles/styles.dart';

class Buraco {
  static buraco(double right, double top) {
    return Positioned(
      top: top,
      right: right,
      child: Container(
        width: 30,
        height: 30,
        color: Cores.vermelho,
      ),
    );
  }
}
