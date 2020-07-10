import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
        ),
      ),
    );
  }
}
