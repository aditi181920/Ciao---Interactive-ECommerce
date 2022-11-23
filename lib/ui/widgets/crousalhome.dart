import 'package:app1/ui/productscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_state.dart';

import '../../model/product_model.dart';

class CrousalHome extends StatefulWidget {
  final List<String> images;
  final List<ProdModel> det;
  const CrousalHome({
    Key? key,
    required this.images,
    required this.det,
  }) : super(key: key);

  @override
  State<CrousalHome> createState() => _CrousalHomeState();
}

class _CrousalHomeState extends State<CrousalHome> {
  @override

  Widget build(BuildContext context) {

    return CarouselSlider(
      items:widget.det.map((i) {
        return Builder(
          builder: (BuildContext context) =>
              GestureDetector(
                child: Image.asset(
                  i.image1!,
                  fit: BoxFit.cover,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  ProductPage(p:i)),);
                },
              ),
        );
      }
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height,

      ),
    );

  }
}