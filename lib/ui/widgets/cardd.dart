import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buildCard extends StatelessWidget {
  final String text;
  const buildCard ({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
    //  shadowColor: Colors.pink,
      elevation: 8,
      color: Colors.grey[850],
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        //change this to change color of the card
        // decoration: const BoxDecoration(
        //     // gradient: LinearGradient(
        //     //   colors: [Colors.deepPurple,Colors.purple],
        //     //   begin: Alignment.topCenter,
        //     //   end: Alignment.bottomCenter,
        //     // )
        //   color: Colors.black12,
        // ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style:GoogleFonts.acme(
                  textStyle: const  TextStyle(
                  color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    wordSpacing: 6.0,

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
