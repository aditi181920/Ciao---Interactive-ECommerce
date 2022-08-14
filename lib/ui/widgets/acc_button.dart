import 'package:flutter/material.dart';
class AccButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const AccButton({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent,width: 0.0),
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurpleAccent.withOpacity(0.3),

      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
            shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                ),
            ),
        child: Text(
          text,textAlign: TextAlign.center,
          style:TextStyle(
            color: Colors.white,
            fontSize: 20,

          )

        ),
        onPressed:ontap,
      ),
    );
  }
}
