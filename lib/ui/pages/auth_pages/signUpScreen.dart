import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automation/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:notful/model/user_repository.dart';
import 'package:notful/model/verification/addFacetoPerson.dart';
import 'package:notful/model/verification/createPerson_model.dart';
import 'package:notful/model/verification/createPerson_service.dart';
import 'package:notful/model/verification/identification.dart';
import 'package:notful/ui/widgets/dpWidget.dart';
import 'package:notful/ui/widgets/textDesign.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image/image.dart' as imd;
import '../../../main.dart';
import '../home.dart';

enum Verification {
  initialise,
  notVerified,
  verifying,
  verified,
}
enum Uploading {
  notUploaded,
  isUploading,
  uploaded,
  error,
}

class SignupPage extends StatefulWidget {
  final UserRepository user;
  SignupPage({this.user});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  TextEditingController _bio;
  TextEditingController _fullname;
  FocusNode _bioField;
  FocusNode _passwordField;
  FocusNode _confirmPasswordField;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool nextpage;
  File _image;
  bool isUploaded = false;
  Verification status;
  Uploading uStatus;

  @override
  void initState() {
    super.initState();
    status = Verification.initialise;
    uStatus = Uploading.notUploaded;
    nextpage = false;
    _fullname = TextEditingController(text: "");
    _bio = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _confirmPassword = TextEditingController(text: "");
    _passwordField = FocusNode();
    _confirmPasswordField = FocusNode();
    _bioField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: textRich("Sign", "Up", Colors.black, Colors.grey, 48)
                    .objectTopLeft(),
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Stack(
                  children: [
                    dpWidget(
                        url:
                            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                        image: _image,
                        radius: 100),
                    Positioned(
                      top: 110,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100))),
                            width: 210,
                            height: 100,
                          ),
                          Positioned(
                            top: 20,
                            left: 83,
                            child: Icon(
                              LineIcons.edit,
                              color: Colors.grey.withOpacity(.75),
                              size: 50,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              nextpage ? userCredForm() : socialInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Form socialInfo() {
    return Form(
      key: _formKey2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: TextFormField(
                key: Key("name-field"),
                controller: _fullname,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Your Name" : null,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: InputBorder.none),
                style: style,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_bioField);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: TextFormField(
                focusNode: _bioField,
                key: Key("bio-field"),
                controller: _bio,
                maxLength: 100,
                maxLines: 3,
                validator: (value) =>
                    (value.isEmpty) ? "Say something about yourself" : null,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    labelText: "Bio",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: InputBorder.none),
                style: style,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {},
              ),
            ),
            SizedBox(height: 12.0),
            Center(
              child: ButtonTheme(
                buttonColor: Colors.black,
                minWidth: MediaQuery.of(context).size.width * .88,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  onPressed: uStatus == Uploading.isUploading
                      ? null
                      : () async {
                          if (_formKey2.currentState.validate() &&
                              _fullname.text.isNotEmpty &&
                              _bio.text.isNotEmpty) {
                            isUploaded ? null : await compressAndUpload();
                            setState(() {
                              nextpage = true;
                            });
                          } else if (_fullname.text.isEmpty ||
                              _bio.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('One of Fields is Empty')));
                          }
                        },
                  child: Text(
                    uStatus == Uploading.notUploaded
                        ? "ADD"
                        : uStatus == Uploading.isUploading
                            ? "ADDING..."
                            : "NEXT",
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int id;
  String photoUrl;
  compressAndUpload() async {
    setState(() {
      uStatus = Uploading.isUploading;
    });
    String url = "https://luxand-cloud-face-recognition.p.rapidapi.com/subject";
    await compressPhoto();
    String downloadUrl = await uploadPhoto(_image, storageReference);
    setState(() {
      photoUrl = downloadUrl;
    });
    CreatePerson p;
    p = await createPerson(url, body: {"name": _fullname.text});
    setState(() {
      id = p.id;
    });
    print(p.id.toString());
    Map<String, String> body = {"photo": downloadUrl};
    AddFacetoPerson a = await addFace(p.id, body: body);

    if (a.status == "success") {
      setState(() {
        isUploaded = true;
        uStatus = Uploading.uploaded;
      });
    } else {
      setState(() {
        isUploaded = false;
        uStatus = Uploading.notUploaded;
      });
    }
  }

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  compressPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    imd.Image mImagefile = imd.decodeImage(_image.readAsBytesSync());
    final compressedImagefile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(imd.encodeJpg(mImagefile, quality: 60));
    setState(() {
      _image = compressedImagefile;
    });
  }

  String postId = Uuid().v4();
  String vId = Uuid().v4();

  Future<String> uploadPhoto(mImagefile, storageReference) async {
    StorageUploadTask mStorageUploadTask =
        storageReference.child("post_$postId.jpg").putFile(mImagefile);
    StorageTaskSnapshot storageTaskSnapshot =
        await mStorageUploadTask.onComplete;
    String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
    print(downloadurl);
    return downloadurl;
  }

  startVerification() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    imd.Image mImagefile = imd.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path/img_$vId.jpg')
      ..writeAsBytesSync(imd.encodeJpg(mImagefile, quality: 60));
    setState(() {
      status = Verification.verifying;
    });
    String verificationUrl =
        await uploadPhoto(compressedImagefile, verificationReference);
    List<Identification> i = new List();
    i = await verify(body: {"photo": verificationUrl});
    bool verification = false;
    print(id.toString());
    print(i.length.toString());
    for (int j = 0; j < i.length; j++) {
      if (i[j].probability > .5) {
        print("verified");
        verification = true;
      } else {
        print('not verified');
      }
    }
    setState(() {
      verification
          ? status = Verification.verified
          : status = Verification.notVerified;
    });
  }

  Form userCredForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: TextFormField(
                key: Key("email-field"),
                controller: _email,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Email" : null,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: InputBorder.none),
                style: style,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordField);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: TextFormField(
                focusNode: _passwordField,
                key: Key("password-field"),
                controller: _password,
                obscureText: true,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Password" : null,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: InputBorder.none),
                style: style,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_confirmPasswordField);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: TextFormField(
                key: Key("confirm-password-field"),
                controller: _confirmPassword,
                obscureText: true,
                validator: (value) => (value.isEmpty)
                    ? "Please Enter Confirm Password"
                    : value.isNotEmpty &&
                            _password.text != _confirmPassword.text
                        ? "Passwords do not match"
                        : null,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: InputBorder.none),
                style: style,
                focusNode: _confirmPasswordField,
                onEditingComplete: () {
                  setState(() {
                    nextpage = true;
                  });
                },
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * .88,
              child: ButtonTheme(
                buttonColor: Colors.black,
                height: 60,
                child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        status == Verification.verifying
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SpinKitChasingDots(
                                  color: Colors.transparent,
                                ),
                              )
                            : Container(),
                        Text(
                          status == Verification.initialise
                              ? "Start Verification".toUpperCase()
                              : status == Verification.verifying
                                  ? "VERIFYING"
                                  : status == Verification.verified
                                      ? "VERIFIED"
                                      : "NOT VERIFIED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              letterSpacing: 1.5),
                        ),
                        status == Verification.verifying
                            ? SpinKitChasingDots(
                                color: Colors.white,
                              )
                            : Container()
                      ],
                    ),
                    onPressed: status == Verification.verified ||
                            status == Verification.verifying
                        ? null
                        : startVerification),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    color: Colors.black,
                    highlightElevation: 0,
                    onPressed: () {
                      setState(() {
                        nextpage = false;
                      });
                    },
                    child: Text(
                      "Prev",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      highlightElevation: 0,
                      onPressed: status == Verification.verified
                          ? () => _signup(widget.user)
                          : null,
                      child: widget.user.status == Status.Authenticating
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text("Signup"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signup(user) async {
    print(widget.user.status);
    if (_formKey.currentState.validate()) {
      if (!await user.signup(
          email: _email.text,
          password: _password.text,
          fullname: _fullname.text,
          bio: _bio.text,
          photoUrl: photoUrl)) {
        _key.currentState.showSnackBar(SnackBar(
          content: Text(user.error),
        ));
      } else {
        Navigator.pushAndRemoveUntil(
            _key.currentContext,
            MaterialPageRoute(
              builder: (context) => AuthHomePage(),
            ),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
