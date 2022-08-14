import 'package:app1/ui/widgets/acc_button.dart';
import 'package:app1/ui/widgets/crousal.dart';
import 'package:app1/ui/widgets/prod_button.dart';
import 'package:app1/ui/widgets/stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app1/services/loginuser.dart';

import '../model/product_model.dart';

class ProductPage extends StatelessWidget {
  final ProdModel p;
  const ProductPage({Key? key,
  required this.p,
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //stack a crousal then half container with linear gradient
    //
    // final List<String> images=[
    //   // 'assets/limite edition/1.webp',
    //   // 'assets/limite edition/4.webp',
    //   'assets/limite edition/2.jpg',
    //   'assets/limite edition/3.jpg',
    //   'assets/limite edition/5.jpg',
    //   'assets/limite edition/6.jpg',
    //   'assets/limite edition/7.jpg',
    //   'assets/limite edition/8.jpg',
    //   'assets/limite edition/9.jpg',
    //
    //
    // ];
    final List<String> images=[
      p.image1!,p.image2!
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Stack(
        children: [
          Crousal(images: images),
          Column(
            children:[
              Container(
                height: 700.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.transparent,Colors.white.withOpacity(0.2),Colors.white.withOpacity(0.5),Colors.white.withOpacity(0.9),Colors.white],
                  ),
                )
                ,
              ),
              Container(
                width: 200,
                height: 50,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  child:Text('Scroll here'),
                ),

              ),
            ],
          ),
          //display all product details
          Container(
              child:Row(
                children: [
                  Container(
                    height: 600.0,
                    width: MediaQuery.of(context).size.width/2,
                  ),
                  Container(
                    height: 700.0,
                    width: MediaQuery.of(context).size.width/2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(100,0.0,60.0,0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50,),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            child: Text('${p.name}',),
                          ),
                          SizedBox(height: 10,),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            child: Text('${p.price}: \$10',),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            child: Text('${p.price}: \$10'),
                          ),
                          SizedBox(height: 10,),
                          Stars(rating:4.0),
                          SizedBox(height: 10,),
                          Divider(
                            color: Colors.black,
                            height: 5,
                            thickness: 1,
                          ),
                          SizedBox(height: 30,),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            child: Text('WHY CHOOSE WHAT YOU PAY?'),
                          ),
                          SizedBox(height: 10,),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            child: Text("${p.description}"),
                          ),
                          SizedBox(height: 30,),
                          Divider(
                            color: Colors.black,
                            height: 5,
                            thickness: 1,
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProdButton(text: 'Add to Cart', ontap: () {
                                FireCloud().addtoCart(p.id!);
                              }),
                              ProdButton(text: 'Add to WishList', ontap: (){}),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.only(left: 10),
                              itemBuilder: (context,_)=> Icon(
                                Icons.star,
                                color: Colors.yellowAccent,
                              ),
                              onRatingUpdate: (rating){},

                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                ],
              )


          ),
        ],
      ),
    );
  }
}
