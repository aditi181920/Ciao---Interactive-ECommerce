import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class Product extends StatelessWidget {
  //final String image;
  final ProdModel p;
  const Product({
    Key? key,
    //required this.image,
    required this.p,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 400.0,
      decoration: BoxDecoration(
        image:DecorationImage(
          image: AssetImage(p.image1!),
          fit:BoxFit.cover,
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }
}
