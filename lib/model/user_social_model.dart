import 'package:cloud_firestore/cloud_firestore.dart';

class UserSocial{
  final String email;
  final String uid;
  final String username;
  final List followers;
  final List following;
  final List likes;

  UserSocial({
    required this.email,
    required this.uid,
    required this.username,
    required this.followers,
    required this.following,
    required this.likes,
  });
  Map<String,dynamic> toMap()=>{
    'username':username,
    'uid':uid,
    'email':email,
    'followers':followers,
    'following':following,
    'likes':likes,
  };
  static UserSocial fromSnap(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic>;
    return UserSocial(
      username:snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      likes: snapshot['likes'],
    );
  }
}