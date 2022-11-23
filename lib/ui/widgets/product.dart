import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class Product extends StatefulWidget {
  //final String image;
  final ProdModel p;
  const Product({
    Key? key,
    //required this.image,
    required this.p,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 400.0,
      decoration: BoxDecoration(
        image:DecorationImage(
          image: AssetImage(widget.p.image1!),
          fit:BoxFit.cover,
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }
}
