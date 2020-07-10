import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar header(
  String title,
) {
  return AppBar(
    elevation: 0.0,
    title: title.text.black.size(30).black.extraBold.make(),
    centerTitle: true,
  );
}
