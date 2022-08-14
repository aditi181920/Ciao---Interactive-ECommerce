import 'package:flutter/cupertino.dart';

class ProdModel{
  String? category;
  String? description;
  String? id;
  String? image1;
  String? image2;
  String? name;
  String? price;
  String? quantity;
  String? tot;
  String? cntu;


  ProdModel({this.category,this.description,this.id,this.image1,this.image2 ,this.name,this.price,this.quantity,this.tot,this.cntu});

  //data from server
  factory ProdModel.fromMap(Map<String,dynamic> map){
    return ProdModel(
      category: map['category'],
      description: map['description'],
      id:map['id'],
      image1: map['image1'],
      image2: map['image2'],
      name:map['name'],
      price:map['price'],
      quantity: map['quantity'],
      tot: map['tot'],
      cntu: map['cntu'],
    );
  }

  //sending data to server
  Map<String,dynamic> toMap(){
    return{
      'category':category,
      'description':description,
      'id':id,
      'image1':image1,
      'image2':image2,
      'name':name,
      'price':price,
      'quantity':quantity,
      'tot':tot,
      'cntu':cntu,
    };
  }

}