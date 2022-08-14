import 'package:flutter/cupertino.dart';

class UserModel{
  String? uid;
  String? email;
  String? password;
  String? address;
  String? name;
  String? rating;
  List<String>? cart;


  UserModel({this.uid,this.email,this.password,this.address, this.name,this.rating,this.cart});

  //data from server
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      uid:map['uid'],
      email: map['email'],
      password: map['password'],
      address: map['address'],
      name:map['name'],
      rating:map['rating'],
      cart:map['cart'].cast<String>(),
    );
  }

  //sending data to server
  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'password':password,
      'address':address,
      'name':name,
      'rating':rating,
      'cart':cart,
    };
  }

}