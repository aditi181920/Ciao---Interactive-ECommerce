import 'package:app1/model/user_model.dart';
import 'package:app1/services/loginuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireServ {

  final _auth = FirebaseAuth.instance;

  Future<String> signUp({required String name,required String email,required String password,required String address})async{
    String out;
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        await FireCloud().postDetailsToFirestore(name: name, email: email, password: password, address: address);
            out="success";
      }on FirebaseAuthException catch(e){
        out=e.code;
        Fluttertoast.showToast(msg: e.code);
        print(e.code);
      }
      return out;
  }

  Future<String> signIn({required String email,required String password})async{
    String out;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      out="success";

      print('Sign in successful');
    }on FirebaseAuthException catch(e){
      out=e.code;
      Fluttertoast.showToast(msg: e.code);
      print(e.code);
    }
    return out;
  }


}