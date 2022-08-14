import 'package:app1/model/user_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/product_model.dart';

class FireCloud{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future postDetailsToFirestore({required String name,required String email,required String password,required String address}) async {
    //call firestore
    //call usermodel
    //sending these values


    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.password=password;
    userModel.name=name;
    userModel.address=address;
    await firebaseFirestore
        .collection('users')   //go to collection
        .doc(user.uid)         //go to that document
        .set(userModel.toMap());   //set the values
    Fluttertoast.showToast(msg: 'Account created successful');
  }

  Future addtoCart(String aid) async{
    User? user = _auth.currentUser;
    await firebaseFirestore
        .collection('users')   //go to collection
        .doc(user?.uid)         //go to that document
        .update({'cart':FieldValue.arrayUnion([aid])});
  }

  Future getData() async{
    DocumentSnapshot snap= await firebaseFirestore
        .collection('users').doc(_auth.currentUser!.uid).get();
    UserModel user=UserModel.fromMap((snap.data() as dynamic),);
    print('we are printing user model');
    print(user);
    return user;
  }

  Future<List<ProdModel>> getAllData() async{
    print('lets fetch data from firebase');

    QuerySnapshot<Map<String,dynamic>> snap= await firebaseFirestore
        .collection('product').get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    print('data fetched from firebase');
    print(item.length);
    print(item);
    return item;
  }

  //fetch and return list of relevant categories from the database
  Future<List<ProdModel>> getCatData(String query) async{
    print('lets fetch data from firebase');

    QuerySnapshot<Map<String,dynamic>> snap= await firebaseFirestore
        .collection('product').where('category',isEqualTo: query).get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    print('data fetched from firebase');
    print(item.length);
    print(item);
    return item;
  }
  Future<ProdModel> getProd(String pid) async{
    QuerySnapshot<Map<String,dynamic>> snap=await firebaseFirestore
        .collection('product').where('id',isEqualTo: pid).get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    return item[0];
}

  Future<List<ProdModel>> out(UserModel user)async{
    List<ProdModel> fetchitem=[];
    for(int i=0;i<user.cart!.length;i++){
      fetchitem.add(await FireCloud().getProd(user.cart![i]));
    }
    print('fetchitem size');
    print(fetchitem.length);
    return fetchitem;
  }

}