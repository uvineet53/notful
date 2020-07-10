import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notful/ui/pages/home.dart';

void main() {
  runApp(MyApp());
}

final StorageReference storageReference =
    FirebaseStorage.instance.ref().child("Posts Pictures");

final StorageReference verificationReference =
    FirebaseStorage.instance.ref().child("Verification Directory");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthHomePage(),
    );
  }
}
