import 'package:app1/model/user_social_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:app1/providers/user_social_detail.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/postaddscreen.dart';
import 'package:app1/ui/postfavscreen.dart';
import 'package:app1/ui/posthomescreen.dart';
import 'package:app1/ui/postscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brandscreen.dart';
import 'fashionscreen.dart';
import 'groupscreen.dart';
import 'live.dart';
import 'messagescreen.dart';
import 'otheraccscreen.dart';

//this widget holds the side bar
class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  int index = 0;
  final selectedColor = Colors.deepPurple;
  final unselectedColor = Colors.white;
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  bool isExtended = false;
  @override
  void initState() {
    super.initState();
   // addData();
  }

  addData() async {
    UserSocialProvider _socialuser = Provider.of(context, listen: false);
    await _socialuser.refreshUser();
    UserSocial _user = _socialuser.user!;
    print('social user details are ');
    print(_user.username);
    print(_user.email);
    print(_user.uid);
  }

  @override
  Widget build(BuildContext context) {
    UserSocial _user=Provider.of<UserSocialProvider>(context,listen: false).user!;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            groupAlignment: -0.8, //-1 for top and 1 for bottom
            extended: isExtended, //to inform navigation rail about extension
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index =
                  index; //this function sets the index of the sidebar after someone clicks it
            }),
            elevation: 2,
            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
            // labelType: NavigationRailLabelType.all, //cant use this with extended
            selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
            unselectedLabelTextStyle:
                labelStyle.copyWith(color: unselectedColor),
            leading: InkWell(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Icon(
                    Icons.account_circle,
                    size: 50,
                  )),
              onTap: () {
                setState(() {
                  isExtended = !isExtended;
                });
              },
            ),
            selectedIconTheme: IconThemeData(
              color: Colors.deepPurple,
              size: 30,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.white,
              size: 30,
            ),

            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.camera),
                label: Text('Stories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle),
                label: Text('Add posts'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favourite'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.note),
                label: Text('Live stream'),
              ),
            ],
          ),
          Expanded(child: buildPages()),
        ],
      ),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return brandPage();
      case 1:
        return postHome();
      case 2:
        return postAdd();
      case 3:
        return postFav();
      case 4:
        return fashionCommPage();
      default:
        return brandPage();
    }
  }
}
