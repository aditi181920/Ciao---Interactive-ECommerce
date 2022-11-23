import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  final double sz;
  const Stars({
    Key? key,
    required this.rating,
    required this.sz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: sz,
      itemBuilder:(context,_)=>
      const Icon(Icons.star,color: Colors.yellowAccent,),
    );
  }
}
