import 'package:app1/model/user_model.dart';
import 'package:app1/services/loginuser.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  UserModel user;
  UserProvider()
      : user = UserModel(uid: "loading",email: "loading",password: "loading", address: "Loading",name: "loading");
  Future getData() async{
    user=await FireCloud().getData();
    print('updating to current user');
    print(user);
    notifyListeners();
  }

}