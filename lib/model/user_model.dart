import 'dart:convert';

import 'package:app1/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserModel{
  String uid;
  String email;
  String password;
  String address;
  String name;
  String rating;
  //List<ProdModel> cart;


  UserModel({required this.uid,required this.email,required this.password,required this.address,required this.name,required this.rating});

  //data from server
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      uid:map['uid'],
      email: map['email'],
      password: map['password'],
      address: map['address'],
      name:map['name'],
      rating:map['rating'],
      // cart:List<Map<String,dynamic>>.from(
      //   map['cart']?.map(
      //       (x)=> Map<String,dynamic>.from(x),
      //   ),
      // ),
      // cart: List<ProdModel>.from(map['cart']?.map(
      //     (x)=> ProdModel.fromMap(x),
      //   ),
      // ),
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
      //'cart':cart,
      //'cart':cart.map((e) => e.toMap()).toList(),
    };
  }

}