import 'package:app1/model/user_social_model.dart';
import 'package:app1/providers/user_social_detail.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/widgets/commentcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final postId;
  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController=TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _commentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final UserSocial user=Provider.of<UserSocialProvider>(context,listen: false).user!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.3),
        title: Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.
        collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .snapshots(),
        builder: (context, snapshot) {
         if(snapshot.connectionState==ConnectionState.waiting) {
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         //we have to do builder like this if we don't explicitly provide the snapshot type as async...
          //since snapshot async type has not been defined we cannot use .docs property directly on it
          return ListView.builder(
            controller: ScrollController(),
             itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context,index)=>CommentCard(
              snap:(snapshot.data! as dynamic).docs[index],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: EdgeInsets.only(left:16,right:8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/av.png'),
                  radius: 18,
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0,right: 8.0),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Comment as ${user.username}',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                ),
                InkWell(
                  onTap:()async{
                    await FireCloud().postComment(
                        widget.postId,
                        _commentController.text,
                        user.uid,
                        user.username);
                    setState(() {
                      _commentController.text="";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
