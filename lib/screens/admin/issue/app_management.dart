import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_spot_finder/models/issue.dart';
import 'package:focus_spot_finder/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_spot_finder/screens/admin/issue/notification_list_body.dart';
import 'package:focus_spot_finder/screens/admin/issue/reports_list_body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class appManagement extends StatefulWidget {
  final void Function() onBackPress;
  const appManagement({Key key, @required this.onBackPress}) : super(key: key);
  @override
  State<appManagement> createState() => _appManagementState();
}

class _appManagementState extends State<appManagement> {
  final issues = Issue();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBackPress();
        return false;
      },
      child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade100,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 30),
            tooltip: 'Back',
            onPressed: widget.onBackPress,
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Image.asset('assets/firebase.png',
                    fit: BoxFit.fitHeight, height: 32),
                tooltip: 'Firebase',
                onPressed: () {
                  launchFirebase();
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Reports",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))),
              Tab(icon: Text("Notifications",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))),
            ],
          ),
          toolbarHeight: 55,
        ),
        body: TabBarView(
          children: [
            reportsListBody(),
            notificationsListBody(),

          ],

      ),
      )
    ),
    );
  }

  Future<void> launchFirebase() async {
    String url = "https://firebase.google.com/?gclid=Cj0KCQiAmeKQBhDvARIsAHJ7mF6OmPIeu2W7gn63okFHkH8LhJvzQ7fQhWAUKbBA49A0IutQzYCMBEgaArhQEALw_wcB&gclsrc=aw.ds";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "Could not open this website",
        toastLength: Toast.LENGTH_LONG,
      );
      throw 'Could not open this website';
    }
  }

}
