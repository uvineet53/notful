import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notful/model/user_repository.dart';
import 'package:notful/ui/widgets/dpWidget.dart';
import 'package:notful/ui/widgets/textDesign.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firestoreInstance = Firestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context, listen: false).user;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: firestoreInstance.document(user.uid).snapshots(),
          builder: (context, snapshot) {
            DocumentSnapshot userProfile = snapshot.data;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 10, spreadRadius: 5)
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              child: !snapshot.hasData
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dpWidget(
                            url: userProfile["photoUrl"],
                            radius: 80,
                            image: null),
                        textRich(
                            userProfile["fullName"].substring(
                                0, userProfile["fullName"].indexOf(" ")),
                            userProfile["fullName"].substring(
                                userProfile["fullName"].indexOf(" ")),
                            Colors.black,
                            Colors.grey[600],
                            25),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            userProfile["bio"],
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "  Posts  ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      height: 1.6,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                "256"
                                    .text
                                    .black
                                    .textStyle(
                                        TextStyle(fontWeight: FontWeight.w900))
                                    .size(30)
                                    .make(),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 20,
                                      height: 1.6,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                "765"
                                    .text
                                    .black
                                    .textStyle(
                                        TextStyle(fontWeight: FontWeight.w900))
                                    .size(30)
                                    .make(),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  " Follows ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      height: 1.6,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                "136"
                                    .text
                                    .black
                                    .textStyle(
                                        TextStyle(fontWeight: FontWeight.w900))
                                    .size(30)
                                    .make(),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
