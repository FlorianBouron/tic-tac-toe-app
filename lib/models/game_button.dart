import 'package:flutter/material.dart';

class GameButton {
  final int id;
  String text;
  Color background;
  bool isClickable;

  GameButton({
    @required this.id,
    this.text = "",
    this.background = Colors.grey,
    this.isClickable = true,
  });
}
