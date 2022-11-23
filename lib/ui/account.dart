import 'dart:math';
import 'dart:ui';

import 'package:app1/providers/user_detail.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/singinp.dart';
import 'package:app1/ui/widgets/acc_button.dart';
import 'package:app1/ui/widgets/cardd.dart';
import 'package:app1/ui/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../model/user_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
   // final UserModel loggedInUser = Provider.of<UserProvider>(context, listen: false).user;
   // print('name on account screen ${loggedInUser.name}');
    return Scaffold(
        body: SafeArea(
      child: Consumer<UserProvider>(
        builder: (context,prov,child) {
          final loggedInUser=prov.user;
          return Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                '13.png',
                color: Color.fromRGBO(255, 255, 255, 1),
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.fill,
              )),
              Padding(
                padding: EdgeInsets.fromLTRB(150.0, 0.0, 150.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: new ClipRect(
                        child: new BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: new Container(
                            width: 400.0,
                            height: 500.0,
                            decoration: new BoxDecoration(
                                color: Colors.white.withOpacity(0.3)),
                            child: new Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your Actions',
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent[200]
                                            ?.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.blue[400],
                                    height: 5,
                                    thickness: 1,
                                    indent: 30,
                                    endIndent: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AccButton(text: 'Your Orders', ontap: () {}),
                                      AccButton(
                                          text: 'Your wishlist', ontap: () {}),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AccButton(
                                          text: 'Change Address', ontap: () {}),
                                      AccButton(
                                        text: 'Logout',
                                        ontap: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInPage()),
                                              (route) => false);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: new ClipRect(
                        child: new BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: new Container(
                            width: 400.0,
                            height: 500.0,
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.5)),
                            child: new Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your Profile',
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[400]?.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.blue[400],
                                    height: 5,
                                    thickness: 1,
                                    indent: 30,
                                    endIndent: 30,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.red[200]?.withOpacity(0.6),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                40.0, 20.0, 40.0, 0.0),
                                            child: Text(
                                              'Name         : ${loggedInUser.name}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                40.0, 20.0, 40.0, 0.0),
                                            child: Text(
                                              'Email          : ${loggedInUser.email}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                40.0, 20.0, 40.0, 0.0),
                                            child: Text(
                                              'Password  : ${loggedInUser.password}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                40.0, 20.0, 40.0, 20.0),
                                            child: Text(
                                              'Address     : ${loggedInUser.address}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    ));
  }
}
