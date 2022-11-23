import 'package:app1/model/user_social_model.dart';
import 'package:app1/ui/postaccscreen.dart';
import 'package:app1/ui/postaddscreen.dart';
import 'package:app1/ui/postfavscreen.dart';
import 'package:app1/ui/posthomescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_navigation/side_navigation.dart';

import '../providers/user_social_detail.dart';

class postPage extends StatefulWidget {
  const postPage({Key? key}) : super(key: key);

  @override
  State<postPage> createState() => _postPageState();
}

class _postPageState extends State<postPage> {
  List<Widget> views = const [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Add post'),
    ),
    Center(
      child: Text('Favorite'),
    ),
    Center(
      child: Text('Account'),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserSocialProvider>(context,listen:false).refreshUser();
    return Scaffold(
      /// You can use an AppBar if you want to
      //appBar: AppBar(
      //  title: const Text('App'),
      //),
      // appBar: AppBar(
      //   toolbarHeight: 60,
      //   title: Padding(
      //       padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
      //       child: Text('Halo',
      //         style: TextStyle(
      //           fontSize: 30,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //   ),
      //   backgroundColor: Colors.blue.withOpacity(0.5),
      // ),

      // The row is needed to display the current view
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              // SideNavigationBarItem(
              //   icon: Icons.search,
              //   label: 'Search',
              // ),
              SideNavigationBarItem(
                icon: Icons.add_circle,
                label: 'Add post',
              ),
              SideNavigationBarItem(
                icon: Icons.favorite,
                label: 'Favorite',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Account',

              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            theme: SideNavigationBarTheme(
              backgroundColor: Colors.purpleAccent.withOpacity(0.15),
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme:SideNavigationBarItemTheme(
                unselectedItemColor: Colors.purple.withOpacity(0.5),
                selectedItemColor: Colors.deepPurpleAccent.withOpacity(0.5),
                iconSize: 30,
              ),

              dividerTheme: SideNavigationBarDividerTheme(
                  showHeaderDivider: true,
                  showMainDivider: true,
                  showFooterDivider: true,

              ),
            ),


          ),

          /// Make it take the rest of the available width
          Expanded(child: buildPages()),
        ],
      ),
    );
  }
  Widget buildPages(){
    switch(selectedIndex){
      case 0:
        return postHome();
      case 1:
        return postAdd();
      case 2:
        return postFav();
      case 3:
        return postAcc();
      default:
        return postHome();
    }
  }
}
