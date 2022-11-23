import 'dart:math';

import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/productscreen.dart';
import 'package:app1/ui/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';
import '../providers/user_detail.dart';
import '../services/loginuser.dart';

//this is cart screen
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // List<ProdModel> c= Provider.of<UserProvider>(context, listen: true).cart;
    // List<ProdModel>   w = Provider.of<UserProvider>(context, listen: true).wish;
    // print('starting to build cart interface ');
    // print('cart length is ');
    // print(c.length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders and Wishlist"),
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
      ),
      body: Consumer<UserProvider>(
        builder: (context,prov,child) {
          List<ProdModel> c=prov.cart;
          List<ProdModel> w=prov.wish;
          return Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.purpleAccent.withOpacity(0.2),
                  child: GridView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 1.3,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 40),
                      itemCount: c.length,
                      itemBuilder: (BuildContext ctx, id) {
                        return GestureDetector(
                          child: Container(
                            height: 700,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(c[id].image1!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    child: Text(
                                      '${c[id].name}',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      //text: '${w[id].price}  ',
                                      style: TextStyle(
                                        wordSpacing: 1.0,
                                        letterSpacing: 1.0,
                                        //  color: Colors.black26,
                                        fontSize: 12,
                                        //   decoration: TextDecoration.lineThrough,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\$${c[id].price}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        TextSpan(
                                          text: '   \$${c[id].sellprice}   ',
                                          style: TextStyle(
                                            color: Colors.purpleAccent,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .setoff(c[id]),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        wordSpacing: 1.0,
                                        letterSpacing: 1.0,
                                        fontSize: 12.0,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: 'Quantity  ${c[id].quantity}',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Stars(rating: (c[id].avgrat), sz: 20),
                                  // Stars(rating: 2.0, sz: 20),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(p: c[id])));
                          },
                        );
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  child: GridView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 1.3,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 40),
                      itemCount: w.length,
                      itemBuilder: (BuildContext ctx, id) {
                        return GestureDetector(
                          child: Container(
                            height: 700,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(w[id].image1!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    child: Text(
                                      '${w[id].name}',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      //text: '${w[id].price}  ',
                                      style: TextStyle(
                                        wordSpacing: 1.0,
                                        letterSpacing: 1.0,
                                        //  color: Colors.black26,
                                        fontSize: 12,
                                        //   decoration: TextDecoration.lineThrough,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\$${w[id].price}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        TextSpan(
                                          text: '   \$${w[id].sellprice}   ',
                                          style: TextStyle(
                                            color: Colors.purpleAccent,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .setoff(w[id]),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // RichText(
                                  //     text: TextSpan(
                                  //       style: TextStyle(
                                  //         wordSpacing: 1.0,
                                  //         letterSpacing: 1.0,
                                  //         fontSize: 12.0,
                                  //       ),
                                  //       children: [
                                  //         TextSpan(
                                  //             text: 'Quantity  ${w[id].quantity}',
                                  //             style: TextStyle(
                                  //               color: Colors.blue,
                                  //               fontSize: 12,
                                  //             )
                                  //         ),
                                  //       ],
                                  //     ),
                                  //
                                  // ),
                                  Stars(rating: (w[id].avgrat), sz: 20),
                                  // Stars(rating: 2.0, sz: 20),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(p: w[id])));
                          },
                        );
                      }),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

//Container(
// color: Colors.deepPurpleAccent.withOpacity(0.2),
// child:GridView.builder(
//     padding:EdgeInsets.all(80.0),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: 2/2.5,
//         crossAxisSpacing: 80,
//         mainAxisSpacing: 80
//     ),
//     itemCount: fetchitem.length,
//     itemBuilder: (BuildContext ctx, index) {
//       return GestureDetector(
//         child: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: 220,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           //fetchitem[index].image1!),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   // color: Colors.amber,
//                   // borderRadius: BorderRadius.circular(15)),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(30.0),
//                   child: Center(
//                     child: Text(fetchitem[index].name!,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis,
//
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         onTap: ()async {
//           // Navigator.push(context, MaterialPageRoute(builder:(context)=>CatScreen(item:fetchitem)),
//           //
//           // );
//         },
//       );
//     }),
//),