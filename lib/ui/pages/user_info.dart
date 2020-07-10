import 'package:flutter/material.dart';
import 'package:notful/model/verification/createPerson_model.dart';
import 'package:notful/model/verification/createPerson_service.dart';
import 'package:notful/ui/widgets/header.dart';
import 'package:provider/provider.dart';
import '../../model/user_repository.dart';

class UserInfoPage extends StatelessWidget {
  String url = "https://luxand-cloud-face-recognition.p.rapidapi.com/subject";
  Map<String, String> body = {"name": "Ankit Upadhyay"};
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context, listen: false).user;
    return Scaffold(
      appBar: header("Home"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email == null ? "No User" : user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () =>
                  Provider.of<UserRepository>(context, listen: false).signOut(),
            ),
            RaisedButton(
                child: Text("Create Person"),
                onPressed: () async {
                  await createPerson(url, body: body);
                })
          ],
        ),
      ),
    );
  }
}
