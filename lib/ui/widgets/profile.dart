import 'package:app1/model/user_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel loggedInUser=Provider.of<UserProvider>(context,listen: false).user;
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name', style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(
            height: 5,
            width: 0,
          ),
          Text(

            '${loggedInUser.name}',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.0,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.greenAccent,
            ),

          ),
          Divider(
            color: Colors.greenAccent,
            height: 5,
            thickness: 1,
            indent: 0,
            endIndent: 20,
          ),

          Text(
            'Email', style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          ),

          SizedBox(
            height: 5,
            width: 0,
          ),
          Text(

            '${loggedInUser.email}',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.0,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.greenAccent,
            ),

          ),
          Divider(
            color: Colors.greenAccent,
            height: 5,
            thickness: 1,
            indent: 0,
            endIndent: 20,
          ),

          Text(
            'Password', style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          ),

          SizedBox(
            height: 5,
            width: 0,
          ),
          Text(

            '${loggedInUser.password}',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.0,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.greenAccent,
            ),

          ),
          Divider(
            color: Colors.greenAccent,
            height: 5,
            thickness: 1,
            indent: 0,
            endIndent: 20,
          ),

          Text(
            'Address', style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          ),

          SizedBox(
            height: 5,
            width: 0,
          ),
          Text(

            '${loggedInUser.address}',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.0,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.greenAccent,
            ),

          ),
          Divider(
            color: Colors.greenAccent,
            height: 5,
            thickness: 1,
            indent: 0,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
