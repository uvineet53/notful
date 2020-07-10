import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../model/user_repository.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  FocusNode _passwordField;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserRepository user;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _passwordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                key: Key("email-field"),
                controller: _email,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Email" : null,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey)),
                style: style,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordField);
                },
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              child: TextFormField(
                focusNode: _passwordField,
                key: Key("password-field"),
                controller: _password,
                obscureText: true,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Password" : null,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey)),
                style: style,
                onEditingComplete: _login,
              ),
            ),
            SizedBox(height: 10.0),
            if (user.status == Status.Authenticating)
              Center(child: CircularProgressIndicator()),
            if (user.status != Status.Authenticating)
              Center(
                child: ButtonTheme(
                  padding: EdgeInsets.all(8),
                  buttonColor: Colors.black,
                  minWidth: 180,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    onPressed: _login,
                    child: "LOGIN".text.white.bold.size(16).make(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      if (!await user.signIn(_email.text, _password.text))
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(user.error),
        ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
