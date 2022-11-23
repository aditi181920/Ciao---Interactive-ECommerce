import 'package:app1/providers/user_detail.dart';
import 'package:app1/ui/widgets/acc_button.dart';
import 'package:app1/ui/widgets/crousal.dart';
import 'package:app1/ui/widgets/prod_button.dart';
import 'package:app1/ui/widgets/stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app1/services/loginuser.dart';
import 'package:provider/provider.dart';
import 'package:app1/services/loginuser.dart';
import '../model/product_model.dart';

class ProductPage extends StatefulWidget {
  final ProdModel p;
  const ProductPage({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool pres = false;
  double starrate = -1;
  double avg = 0;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    //check if current user exists in products rating collection
    checkifrated(widget.p.id!, _auth.currentUser!.uid.toString());
    print('current rating for the product is ');
    print(starrate);
    findavg(widget.p.id!);
  }

  void checkifrated(String pid, String uid) async {
    double st = await FireCloud().checkifrate(pid: pid, uid: uid);
    setState(() {
      starrate = st;
      print('rating for current product is found to be ');
      print(starrate);
    });
  }

  void findavg(String pid) async {
    double avv = await FireCloud().avgrating(pid: pid);
    setState(() {
      avg = avv;
      print('avg is avg');
      print(avg);
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
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
    final List<String> images = [widget.p.image1!, widget.p.image2!];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Crousal(images: images),
          Column(
            children: [
              Container(
                height: 700.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.9),
                      Colors.white
                    ],
                  ),
                ),
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
                  child: Text('Scroll here'),
                ),
              ),
            ],
          ),
          //display all product details
          Container(
              child: Row(
            children: [
              Container(
                height: 600.0,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Container(
                height: 700.0,
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(100, 0.0, 60.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        child: Text(
                          '${widget.p.name}',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        child: Text(
                          '${widget.p.price}: \$10',
                        ),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        child: Text('${widget.p.price}: \$10'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stars(rating: avg, sz: 15.0),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black,
                        height: 5,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        child: Text('WHY CHOOSE WHAT YOU PAY?'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        child: Text("${widget.p.description}"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        color: Colors.black,
                        height: 5,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProdButton(
                              text: 'Add to Cart',
                              ontap: () {
                                // setState(() {
                                //  FireCloud().addtoCart(widget.p.id!);
                                final userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                userProvider.setCart(widget.p);
                                //});
                              }),
                          ProdButton(
                              text: 'Add to WishList',
                              ontap: () {
                                final userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                userProvider.setWishlist(widget.p);
                              }),
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      //if this user has alredy rated then we just need to put that many stars .. he cannot anything again

                      //how to find that?
                      (starrate != -1)
                          ? Center(child: Stars(rating: starrate, sz: 50))
                          : Center(
                              child: RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(left: 10),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                ),
                                onRatingUpdate: (rating) async {
                                  //must update the rating to reach database
                                  //increment cntu in this product and add this raitng to tot
                                  await FireCloud().rateit(
                                      pid: widget.p.id!,
                                      uid: _auth.currentUser!.uid.toString(),
                                      ratee: rating);
                                  setState(() {});
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
