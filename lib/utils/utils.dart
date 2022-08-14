import 'package:flutter/material.dart';

class Utils{
  showSnackBar({required BuildContext context,required String content}){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(content)
                ],
            ),
        ),
    );
  }
}