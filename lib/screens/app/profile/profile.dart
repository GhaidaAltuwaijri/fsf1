import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_spot_finder/models/user_model.dart';
import 'package:focus_spot_finder/screens/app/chatbot/chatbot.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import '../../../Widget/customClipper.dart';
import 'user_profile.dart';
import 'package:focus_spot_finder/Widget/controller.dart';

class Profile extends StatefulWidget {
  final void Function() onBackPress;

  const Profile({Key key, @required this.onBackPress}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isClicked = false;
  var myController = Get.put(MyController());

  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBackPress();

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade100,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 30),
            tooltip: 'Back',
            onPressed: widget.onBackPress,
          ),
          toolbarHeight: 55,

          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Image.asset('assets/chatbot.png',
                    fit: BoxFit.fitHeight, height: 40),
                tooltip: 'Chatbot',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chatbot()));
                },
              ),
            ),
          ],

        ),
        //end appBar

        body: Container(
          child: Stack(
            children: <Widget>[
              //background decoration
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Container(
                    child: Transform.rotate(
                  angle: -pi / 3.5,
                  child: ClipPath(
                    clipper: ClipPainter(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.cyan.shade50,
                            Colors.cyan.shade400,
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      //the user photo
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Obx(
                          () => Column(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.1,
                                backgroundColor:
                                    Colors.cyan.shade100.withOpacity(0.8),
                                child: ClipOval(
                                  child: Stack(
                                    children: [
                                      myController.f1.value.path.isEmpty
                                          ? (loggedInUser.profileImage !=
                                                      null &&
                                                  loggedInUser
                                                      .profileImage.isNotEmpty)
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  backgroundImage: NetworkImage(
                                                      loggedInUser
                                                          .profileImage),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  backgroundImage: AssetImage(
                                                    'assets/place_holder.png',
                                                  ))
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              backgroundImage: FileImage(
                                                  myController.f1.value),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Column(
                                children: [
                                  Text(" ${myController.userName.value}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.003),
                                  Text(" ${loggedInUser.email}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),

                      //profile button when clicked, open the user profile
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xffe0f7fa).withAlpha(100),
                                    offset: Offset(2, 4),
                                    blurRadius: 8,
                                    spreadRadius: 2)
                              ],
                              color: Colors.cyan.shade50),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.black54,
                                ),
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //sign out button, when clicked call signout method
                      GestureDetector(
                        onTap: () {
                          loggedInUser.alertDialogSignOut(context, () {
                            myController.f1 = File('').obs;
                            loggedInUser.logout(context);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xffe0f7fa).withAlpha(100),
                                    offset: Offset(2, 4),
                                    blurRadius: 8,
                                    spreadRadius: 2)
                              ],
                              color: Colors.cyan.shade50),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.black54,
                                ),
                                Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 100,
                      ),
                      Text("All copyrights are reserved for King Saud University, Riyadh, Saudi Arabia 2022",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ))

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get the user data from firebase
  Future getUserData() async {
    var _data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
    Logger().wtf(_data.data());
    this.loggedInUser = UserModel.fromMap(_data.data());
    myController.userName.value = loggedInUser.name;
    setState(() {});
  }


}
