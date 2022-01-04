import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/box_shadow.dart';
import '../button_press.dart';

Widget buildButton(String buttonVal, double height, double width, WidgetRef ref,
    [Color buttoncolor = const Color(0xFFE0E0E0),
    Color textcolor = const Color(0xFF7F7FA5)]) {
  return Expanded(
      child: Container(
    margin: EdgeInsets.symmetric(
        vertical: height * 0.005, horizontal: width * 0.02),
    decoration: BoxDecoration(
      color: buttoncolor,
      shape: BoxShape.circle,
      boxShadow: [boxShadow1(), boxShadow2()],
    ),
    child: MaterialButton(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        buttonVal,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: textcolor,
        ),
      ),
      onPressed: () => buttonPress.buttonPressed(buttonVal, ref),
    ),
  ));
}
