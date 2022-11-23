import 'package:app1/model/user_social_model.dart';
import 'package:app1/providers/user_social_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/av.png'),
            radius: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                      children:[
                        TextSpan(
                          text: ' ${widget.snap.data()['name']}  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${widget.snap.data()['text']}'
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('23/12/12', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
