import 'package:flutter/material.dart';
class ProdButton extends StatefulWidget {
  final String text;
  final VoidCallback ontap;
  const ProdButton({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);


  @override
  State<ProdButton> createState() => _ProdButtonState();
}

class _ProdButtonState extends State<ProdButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent,width: 0.0),
        //borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurpleAccent.withOpacity(0.8),

      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          // shape:RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
        ),
        child: Text(
            widget.text,textAlign: TextAlign.center,
            style:TextStyle(
              color: Colors.white,
              fontSize: 20,

            )

        ),
        onPressed:widget.ontap,
      ),
    );
  }
}
