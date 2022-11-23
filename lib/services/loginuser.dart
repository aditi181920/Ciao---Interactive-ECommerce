import 'dart:typed_data';

import 'package:app1/model/story.dart';
import 'package:app1/model/user_model.dart';
import 'package:app1/model/user_social_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:app1/services/storage.dart';
import 'package:app1/ui/social.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../model/brand.dart';
import '../model/post.dart';
import '../model/product_model.dart';
import 'package:app1/model/rating.dart';

class FireCloud{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future postDetailsToFirestore({required String name,required String email,required String password,required String address}) async {
    //call firestore
    //call usermodel
    //sending these values


    User? user = _auth.currentUser;
    UserModel userModel = UserModel(uid: '',email: '',password: '',address: '',name: '',rating: '');

    userModel.email=user!.email!;
    userModel.uid=user.uid;
    userModel.password=password;
    userModel.name=name;
    userModel.address=address;
    await firebaseFirestore
        .collection('users')   //go to collection
        .doc(user.uid)         //go to that document
        .set(userModel.toMap());   //set the values
    Fluttertoast.showToast(msg: 'Account created successful');

    UserSocial us=UserSocial(
        email: user.email!,
        uid: user.uid,
        username: name,
        followers: [],
        following: [],
        likes: [],
    );
    await firebaseFirestore
          .collection('socialusers')
          .doc(user.uid)
          .set(us.toMap());
  }

  Future postproddetails({required ProdModel prod})async{
    await firebaseFirestore
        .collection('product')
        .doc(prod.id)
        .set(prod.toMap());
    print('updating product details in firebase ');
  }



  Future getData() async{  //get all data of a particular user
    DocumentSnapshot snap= await firebaseFirestore
        .collection('users').doc(_auth.currentUser!.uid).get();
    UserModel user=UserModel.fromMap((snap.data() as dynamic),);
    // print('we are printing user model');
    // print(user);
    return user;
  }

  Future<List<ProdModel>> getAllData() async{        //get data of all the available products
    //print('lets fetch data from firebase');

    QuerySnapshot<Map<String,dynamic>> snap= await firebaseFirestore
        .collection('product').get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    // print('data fetched from firebase');
    // print(item.length);
    // print(item);
    return item;
  }

  //fetch and return list of relevant categories from the database
  Future<List<ProdModel>> getCatData(String query) async{
    // print('lets fetch data from firebase');

    QuerySnapshot<Map<String,dynamic>> snap= await firebaseFirestore
        .collection('product').where('category',isEqualTo: query).get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    // print('data fetched from firebase');
    // print(item.length);
    // print(item);
    return item;
  }
  Future<ProdModel> getProd(String pid) async{   //get data of a particular product
    QuerySnapshot<Map<String,dynamic>> snap=await firebaseFirestore
        .collection('product').where('id',isEqualTo: pid).get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    return item[0];
   }

   Future<UserPost> getPost(String pid)async{
     QuerySnapshot<Map<String,dynamic>> snap=await firebaseFirestore
         .collection('posts').where('postId',isEqualTo: pid).get();
     List<UserPost> item=snap.docs.map(
             (e)=> UserPost.fromMap(e.data() as Map<String, dynamic>)).toList();
     return item[0];
   }

  // Future addtoCart(String aid) async{
  //   User? user = _auth.currentUser;
  //   await firebaseFirestore
  //       .collection('users')   //go to collection
  //       .doc(user?.uid)         //go to that document
  //       .update({'cart':FieldValue.arrayUnion([aid])});
  // }

  // Future<List<ProdModel>> out(UserModel user)async{
  //   List<ProdModel> fetchitem=[];
  //   for(int i=0;i<user.cart!.length;i++){
  //     fetchitem.add(await FireCloud().getProd(user.cart![i]));
  //   }
  //   print('fetchitem size');
  //   print(fetchitem.length);
  //   return fetchitem;
  // }
  Future addProductToCart({required ProdModel productModel}) async {
    // await firebaseFirestore
    //     .collection("users")
    //     .doc(_auth.currentUser!.uid)
    //     .collection("cart")
    //     .doc(productModel.id)
    //     .set(productModel.toMap());
    //
    ProdModel prod=ProdModel(category: productModel.category,description: productModel.description,id: productModel.id,image1: productModel.image1,image2: productModel.image2,name: productModel.name,price: productModel.price,quantity: 0,tot: productModel.tot,cntu: productModel.cntu);
    await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.id)
        .get()
        .then((docSnapShot) async =>  {
          if(docSnapShot.exists){
            await firebaseFirestore
                .collection("users")
                .doc(_auth.currentUser!.uid)
                .collection("cart")
                .doc(productModel.id)
                .update({'quantity':FieldValue.increment(1)}),
          }else{

            await firebaseFirestore
                .collection("users")
                .doc(_auth.currentUser!.uid)
                .collection("cart")
                .doc(productModel.id)
                .set(prod.toMap()),
          }
    }
    );

  }
  Future addProductToWish({required ProdModel productModel}) async {
    // await firebaseFirestore
    //     .collection("users")
    //     .doc(_auth.currentUser!.uid)
    //     .collection("cart")
    //     .doc(productModel.id)
    //     .set(productModel.toMap());
    //
    ProdModel prod=ProdModel(category: productModel.category,description: productModel.description,id: productModel.id,image1: productModel.image1,image2: productModel.image2,name: productModel.name,price: productModel.price,quantity: 0,tot: productModel.tot,cntu: productModel.cntu);
    await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("wish")
        .doc(productModel.id)
        .get()
        .then((docSnapShot) async =>  {
      if(docSnapShot.exists){
        await firebaseFirestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("wish")
            .doc(productModel.id)
            .update({'quantity':FieldValue.increment(1)}),
      }else{

        await firebaseFirestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("wish")
            .doc(productModel.id)
            .set(prod.toMap()),
      }
    }
    );
  }
  Future<List<ProdModel>> getCart()async{
    QuerySnapshot<Map<String,dynamic>> snap=await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    return item;
  }
  Future<List<ProdModel>> getWish()async{
    QuerySnapshot<Map<String,dynamic>> snap=await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("wish")
        .get();
    List<ProdModel> item=snap.docs.map(
            (e)=> ProdModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    return item;
  }

  // Future countCart() async{
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(_auth.currentUser!.uid)
  //       .collection("cart")
  //       .size;
//  for counting cart items
  // }
  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future updrate({required int rate,required String id})async{
    await firebaseFirestore
        .collection("product")
        .doc(id)
        .update({'cntu':FieldValue.increment(1)});
    //what if the user has already provided the rating ?
  }

  Future<double> checkifrate({required String pid,required String uid})async{
    bool exi=false;
    double starr=0;
    await firebaseFirestore
        .collection("product")
        .doc(pid)
        .collection("rating")
        .doc(uid)
        .get()
        .then((docSnapShot) async =>
    {
      if(docSnapShot.exists){
        //find how much rating
        print('yes this exists '),
        starr=await firebaseFirestore
             .collection("product")
             .doc(pid)
             .collection("rating")
             .doc(uid)
             .get()
             .then((DocumentSnapshot doc){
               final data =doc.data() as Map<String,dynamic>;
               print('data is');
               print(data['rate']);
               return data['rate'];
        }),
        print('ok so final star is '),
        print(starr),
      } else
        {
          print('this does not exists'),
          starr=-1,
        }
    }
    );
    print('returning star');
    print(starr);
    return starr;
  }

  Future rateit( {required String pid,required String uid,required double ratee}) async{
    //send to data base
    print('going to rate the cur product');
    print(pid);
    print(uid);
    await firebaseFirestore
          .collection("product")
          .doc(pid)
          .collection("rating")
          .doc(uid)
          .set({'rate':ratee});
  }

  Future<double> avgrating({required String pid})async{
    //we need to find rating for all users and average them
    double totrate=0;
    double cnt=0;
    await firebaseFirestore
          .collection("product")
          .doc(pid)
          .collection("rating")
          .get()
          .then((QuerySnapshot snap) =>{
             snap.docs.forEach((e) {

               totrate+=rateModel.fromMap(e.data() as Map<String, dynamic>).rate;
               cnt=cnt+1;
                  }
             ),
    });
    print('total people who have rated this product ');
    print(cnt);
    print('total rating provided ');
    print(totrate);
    if(cnt==0)return 0;
    return totrate/cnt;
  }
  //create a function to return all the brand in story colletion and their stories in stories collection
//create sep for returning all brands and other for returning all brand stories
  Future<List<Brand>> retBrand()async{
    List<Brand> re=[];
    await firebaseFirestore
          .collection('story')
          .get()
          .then((QuerySnapshot snap) => {
            snap.docs.forEach((e) {
              re.add(Brand.fromMap(e.data() as Map<String,dynamic>));
            },
          ),
    });
    print('the brand names are:');
    print(re[0].name);
    print(re[0].profileImageUrl);
    return re;
  }

  Future<List<List<Story>>> retstories()async{
    List<List<Story>> stories=[];

    // await firebaseFirestore
    //     .collectionGroup('stories')
    //     .get()
    //     .then((QuerySnapshot snap) => {
    //       snap.docs.forEach((e) {
    //       stories.add(Story.fromMap(e.data() as Map<String,dynamic>));
    //     },
    //   ),
    // });
    List<String > ids=[];
    await firebaseFirestore
         .collection('story')
         .get()
         .then((QuerySnapshot snap) => {
           snap.docs.forEach((element) {ids.add(element.id);})
    });
    for(int i=0;i<ids.length;i++){
      List<Story> temp=[];
      await firebaseFirestore
            .collection('story')
            .doc(ids[i])
             .collection('stories')
            .get()
            .then((QuerySnapshot snap) => {
              snap.docs.forEach((element) {
                temp.add(Story.fromMap(element.data() as Map<String,dynamic>));
              },
            ),
           stories.add(temp),
         }
      );
    }
    print('printing the stories for everything');
    print(stories.length);
    // print(stories[0].duration);
    // print(stories[0].media);
    // print(stories[0].url);
    return stories;
  }
  
  //functions for social page
  Future<UserSocial> getUserDetails() async{
    User curuser=_auth.currentUser!;
    DocumentSnapshot snap=await firebaseFirestore.collection('socialusers')
                                                 .doc(curuser.uid).get();
    return UserSocial.fromSnap(snap);  //why static is req?
  }

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
      await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      UserPost post = UserPost(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
      );
      await firebaseFirestore.collection('posts').doc(postId).set(post.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<void> likePost(String postId,String uid,List likes)async{
    try{
      if(likes.contains(uid)){
        await firebaseFirestore.collection('posts').doc(postId).update(
          {
            'likes':FieldValue.arrayRemove([uid]),
          }
        );
        await firebaseFirestore.collection('socialusers').doc(uid).update(
          {
            'likes':FieldValue.arrayRemove([postId]),
          }
        );
      }else{
        await firebaseFirestore.collection('posts').doc(postId).update(
          {
            'likes':FieldValue.arrayUnion([uid]),
          }
        );
        await firebaseFirestore.collection('socialusers').doc(uid).update(
            {
              'likes':FieldValue.arrayUnion([postId]),
            }
        );
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> postComment(String postId, String text, String uid,String name)async{
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await firebaseFirestore.collection('posts').doc(postId).collection(
            'comments').doc(commentId).set({
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print('Text is empty');
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async{
    try{
      await firebaseFirestore.collection('posts').doc(postId).delete();
    }catch(err){
      print(err.toString());
    }
  }
}