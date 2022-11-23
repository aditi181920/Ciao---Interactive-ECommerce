import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPost{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String datePublished;
  final String postUrl;
 // final String profImage;
  final List<dynamic> likes;

  const UserPost({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
   // required this.profImage,
    required this.likes,

});
  Map<String,dynamic> toMap()=>{
    'description':description,
    'uid':uid,
    'username':username,
    'postId':postId,
    'datePublished':datePublished,
    'postUrl':postUrl,
  //  'profImage':profImage,
    'likes':likes,
  };

  factory UserPost.fromMap(Map<String,dynamic> map){
    return UserPost(
      description: map['description'],
      uid:map['uid'],
      username: map['username'],
      postId: map['postId'],
      datePublished:map['datePublished'],
      postUrl:map['postUrl'],
      likes: map['likes'],
    );
  }
  static UserPost fromSnap(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic>;
    return UserPost(
      username:snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postUrl: snapshot['postUrl'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    //  profImage: snapshot['profImage'],
    );
  }
}