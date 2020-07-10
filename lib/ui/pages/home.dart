import 'package:flutter/material.dart';
import 'package:notful/ui/pages/homepage.dart';
import '../../model/user_repository.dart';
import 'package:provider/provider.dart';
import './splash.dart';
import './login.dart';

class AuthHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
              return WelcomePage();
            case Status.Authenticating:
              return CircularProgressIndicator();
            case Status.Authenticated:
              return Homepage();
          }
        },
      ),
    );
  }
}
