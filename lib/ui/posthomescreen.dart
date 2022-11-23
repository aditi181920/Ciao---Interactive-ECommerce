import 'package:app1/ui/widgets/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_social_model.dart';
import '../providers/user_social_detail.dart';

class postHome extends StatefulWidget {
  const postHome({Key? key}) : super(key: key);

  @override
  State<postHome> createState() => _postHomeState();
}

class _postHomeState extends State<postHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      // ),
      backgroundColor: Colors.purple.withOpacity(0.2),
      body: StreamBuilder(
        //used to listen to realtime streams
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            controller: ScrollController(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => //
                postCard(
            //  snap: snapshot.data!.docs[index].data(),
                  username: snapshot.data!.docs[index].data()['username'],
                  likes: snapshot.data!.docs[index].data()['likes'],
                  postId: snapshot.data!.docs[index].data()['postId'],
                  postUrl: snapshot.data!.docs[index].data()['postUrl'],
                  date: snapshot.data!.docs[index].data()['datePublished'],
                  description: snapshot.data!.docs[index].data()['description'],
            ),
          );
        },
      ),
    );
  }
}
