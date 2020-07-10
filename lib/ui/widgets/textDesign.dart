import 'package:flutter/material.dart';

Widget textRich(String s1, String s2, Color c1, Color c2, double size) {
  return RichText(
      text: TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: s1,
        style:
            TextStyle(color: c1, fontSize: size, fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: s2,
        style:
            TextStyle(color: c2, fontSize: size, fontWeight: FontWeight.bold),
      )
    ],
  ));
}
