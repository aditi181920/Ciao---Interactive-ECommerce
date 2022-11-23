import 'package:app1/model/user_social_model.dart';
import 'package:app1/providers/user_social_detail.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/commentscreen.dart';
import 'package:app1/ui/widgets/like_animation.dart';
import 'package:app1/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../providers/user_detail.dart';
class postCard extends StatefulWidget {
  //final snap;
  final username;
  final likes;
  final postId;
  final postUrl;
  final description;
  final date;
  const postCard({
    Key? key,
   // required this.snap,
    required this.username,
    required this.likes,
    required this.postId,
    required this.postUrl,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  State<postCard> createState() => _postCardState();
}
//use snap['field'] to display the data
class _postCardState extends State<postCard> {
  bool isLikeAnimating=false;
  @override
  void initState(){
    super.initState();
  //  print('post casr: ${widget.snap['username']}');
    pp();
  }
  void pp(){
    // print('value of snap is');
    // print(widget.snap['username']);
    // print(widget.snap['likes']);
    // print(widget.snap['postId']);
    // print(widget.snap['postUrl']);

  }
  @override
  Widget build(BuildContext context) {
    final UserSocial user=Provider.of<UserSocialProvider>(context,listen:false).user!;
    final UserModel curuser=Provider.of<UserProvider>(context,listen:false).user;
    print('printing for postcard');
    print(curuser.name);
    return Container(
      //height: 480,
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 80.0,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            color: Colors.grey,
            child: Row(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/av.png'),
                    ),
                  ),
                Expanded(
                    child:Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
          Container(
            height: 350,
            color: Colors.grey.withOpacity(0.5),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: ()async{
                      await FireCloud().likePost(
                      widget.postId,
                      user.uid,
                      widget.likes,
                      );
                      setState(() {
                        isLikeAnimating=true;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 350,
                          child: Image.network(
                            //widget.snap['postUrl'],
                            widget.postUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        AnimatedOpacity( //since we want our like to appear and disappear
                          duration: Duration(milliseconds: 200),
                          opacity: isLikeAnimating?1:0,
                          child: LikeAnimation(
                              child:Icon(Icons.favorite,color: Colors.white,size: 200,),
                              isAnimating: isLikeAnimating,
                              duration: Duration(
                                milliseconds: 400,
                              ),
                            onEnd: (){
                                setState(() {
                                  isLikeAnimating=false;
                                });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                    child:Container(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LikeAnimation(
                                  isAnimating: widget.likes.contains(user.uid),
                                  smallLike: true,
                                  child: IconButton(
                                      onPressed:()async{
                                        await FireCloud().likePost(widget.postId, user.uid, widget.likes);
                                      },
                                      icon:widget.likes.contains(user.uid)? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                      ): Icon(
                                        Icons.favorite_border_outlined,
                                      )
                                    ,
                                  ),
                                ),
                                IconButton(
                                  onPressed:(){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>CommentScreen(postId: widget.postId,),),
                                    );
                                  },
                                  icon: Icon(Icons.comment_outlined),
                                ),
                                IconButton(
                                  onPressed:(){},
                                  icon: Icon(Icons.near_me),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed:(){},
                                    icon:Icon(Icons.bookmark),
                                  ),
                                ),
                                (curuser.name==widget.username)?
                                 IconButton(
                                     onPressed: (){
                                       FireCloud().deletePost(widget.postId.toString(),);
                                     },
                                     icon: Icon(Icons.delete),
                                  )
                                 :
                                 IconButton(
                                     onPressed: (){
                                       Utils().showSnackBar(
                                           context: context,
                                           content: 'U are not the author of this post'
                                       );
                                     },
                                     icon: Icon(Icons.delete),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28.0,8.0,8.0,8.0),
                            child: Text('${widget.likes.length} likes'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28.0,8.0,8.0,8.0),
                            child: Text('${widget.description}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28.0,8.0,8.0,8.0),
                            child: Text('View all 200 comments'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28.0,8.0,8.0,8.0),
                            child: Text(DateFormat.yMMMd().format(DateTime.parse(widget.date))),
                          ),
                        ],
                      )
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
