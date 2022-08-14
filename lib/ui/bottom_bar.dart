import 'dart:math';

import 'package:app1/model/user_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/account.dart';
import 'package:app1/ui/cart.dart';
import 'package:app1/ui/category.dart';
import 'package:app1/ui/home.dart';
import 'package:app1/ui/social.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page=0;
  List<Widget> routess=[
    HomePage(),
    SocialPage(),
    CategoryPage(),
    CartPage(),
    AccountPage(),
  ];
  @override
  void initState(){
    super.initState();
    FireCloud().getData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).getData();
    double sz=MediaQuery.of(context).size.width;
    UserModel? loggedInUser=Provider.of<UserProvider>(context,listen: false).user;
    print('cart size is:');
    print(loggedInUser.name);
    print(loggedInUser.cart!.length);
    return Scaffold(

      //body: routess[_page],  doing just this does not save state between pages since pages are destroyed as we change the body
      body: IndexedStack(
        index: _page,
        children: routess,       //now our state will be saved as well
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page, //this selects the item in nav bar (0 based indexing)
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.deepPurpleAccent[100],
          backgroundColor: Colors.white,
          iconSize: 30,
          items: [
            //for home
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
              backgroundColor: Colors.white,
              //note that this color is activated  for completed bottom bar if this icon is active
            ),
            //for studio
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: '',
              backgroundColor: Colors.white,
            ),
            //for category
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: '',
              backgroundColor: Colors.white,
            ),
            //for cart
            BottomNavigationBarItem(
              icon: Badge(
                  position: BadgePosition.topEnd(),
                  badgeColor: Colors.redAccent,
                  badgeContent: Text(loggedInUser.cart!.length.toString()),
                  child: Icon(Icons.shopping_cart),
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            //for profile
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '',
              backgroundColor: Colors.white,
            ),
          ],
        onTap: (index)=> setState(() {

          _page=index;
          }),
        ),
    );
  }
}
