import 'package:flutter/material.dart';
class rateModel{
  double rate;
  String review;
  rateModel({required this.rate,required this.review});

  factory rateModel.fromMap(Map<String,dynamic> map){
    return rateModel(
      rate:map['rate'],
      review: map['review'],
    );
  }
  Map<String,dynamic> toMap(){
    return{
      'rate':rate,
      'review':review,
    };
  }
}