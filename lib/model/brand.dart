import 'package:flutter/material.dart';

class Brand{
  final String name;
  final String profileImageUrl;

  Brand({required this.name, required this.profileImageUrl});
  factory Brand.fromMap(Map<String,dynamic> map){
    return Brand(
      name:map['name'],
      profileImageUrl: map['profileImageUrl'],
    );
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'profileImageUrl':profileImageUrl,
    };
  }
}