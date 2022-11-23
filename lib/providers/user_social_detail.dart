import 'package:app1/model/post.dart';
import 'package:app1/model/user_social_model.dart';
import 'package:app1/services/loginuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSocialProvider with ChangeNotifier{
  UserSocial? user;
  List<UserPost> favs=[];
  Future<void> refreshUser() async{
    UserSocial userr=await FireCloud().getUserDetails();
    user=userr;
    print('values for this social user obtained');
    print(user!.username);
    print(user!.likes);
    // if(user!.likes!=null) {
    //   for (int i = 0; i < user!.likes.length; i++) {
    //     UserPost temp = await FireCloud().getPost(user!.likes[i]);
    //     favs.add(temp);
    //   }
    // }
    // print(favs);
    notifyListeners();
  }
  Future<void> findfav() async{
    favs=[];
    if(user!.likes!=null) {
      for (int i = 0; i < user!.likes.length; i++) {
        UserPost temp = await FireCloud().getPost(user!.likes[i]);
        favs.add(temp);
      }
    }
    print(favs);
    notifyListeners();
  }
}