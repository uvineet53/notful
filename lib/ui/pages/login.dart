import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notful/ui/pages/auth_pages/signUpScreen.dart';
import 'package:notful/ui/widgets/login.dart';
import 'package:notful/ui/widgets/signup.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../model/user_repository.dart';
import '../widgets/auth_dialog.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _authVisible;
  int _selectedTab;

  @override
  void initState() {
    super.initState();
    _authVisible = false;
    _selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    UserRepository user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg.png"),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.centerLeft)),
            width: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                flex: 5,
                child: SafeArea(
                    child: Container(
                  transform: Matrix4.translationValues(-107, 20, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: "NOTFUL"
                          .text
                          .color(Colors.white.withOpacity(.8))
                          .size(60)
                          .extraBold
                          .letterSpacing(12)
                          .make(),
                    ),
                  ),
                )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    children: [
                      LoginForm(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HStack(
                          [
                            Text(
                              "Not a member yet? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              child: "Signup".text.red500.bold.wide.make(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupPage(
                                    user: user,
                                  ),
                                ));
                              },
                            ),
                          ],
                        ).centered(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
