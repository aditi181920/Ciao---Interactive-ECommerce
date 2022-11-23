import 'package:app1/ui/productscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_state.dart';

class Crousal extends StatelessWidget {
  final List<String> images;
  const Crousal({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) => Image.asset(
            i,
            fit: BoxFit.cover,
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
