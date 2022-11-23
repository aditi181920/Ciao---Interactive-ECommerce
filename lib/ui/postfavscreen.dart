import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/widgets/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/post.dart';
import '../model/user_social_model.dart';
import '../providers/user_social_detail.dart';
class postFav extends StatefulWidget {
  const postFav({Key? key}) : super(key: key);

  @override
  State<postFav> createState() => _postFavState();
}

class _postFavState extends State<postFav> {
 // QuerySnapshot snap;
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<UserSocialProvider>(context,listen:false).findfav();
    final UserSocial user=Provider.of<UserSocialProvider>(context,listen:false).user!;
    return Scaffold(
      body: Consumer<UserSocialProvider>(
        builder: (context,prov,child) {
          List<UserPost> favv=prov.favs;
          return((favv==null)|(favv.isEmpty))?
            CircularProgressIndicator():
           ListView.builder(
                controller: ScrollController(),
                itemCount: favv.length,
                itemBuilder: (context, index) => //
                postCard(
                  //  snap: snapshot.data!.docs[index].data(),
                  username: favv[index].username,
                  likes: favv[index].likes,
                  postId: favv[index].postId,
                  postUrl: favv[index].postUrl,
                  date: favv[index].datePublished,
                  description: favv[index].description,
                ),
              );
        }
      ),
      // stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      // builder: (BuildContext context,
      //     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //   if (snapshot.connectionState == ConnectionState.waiting) {
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   }
      //   return ListView.builder(
      //     controller: ScrollController(),
      //     itemCount: snapshot.data!.docs.length,
      //     itemBuilder: (context, index) => //
      //     postCard(
      //       //  snap: snapshot.data!.docs[index].data(),
      //       username: snapshot.data!.docs[index].data()['username'],
      //       likes: snapshot.data!.docs[index].data()['likes'],
      //       postId: snapshot.data!.docs[index].data()['postId'],
      //       postUrl: snapshot.data!.docs[index].data()['postUrl'],
      //       date: snapshot.data!.docs[index].data()['datePublished'],
      //       description: snapshot.data!.docs[index].data()['description'],
      //     ),
      //   );
      // },
      // // body: ListView.builder(
      // //   itemCount: user.likes.length,
      // //     itemBuilder: (context,id)=>
      // //         postCard(snap:user.likes[id]),
      // // ),
    );
  }
}
