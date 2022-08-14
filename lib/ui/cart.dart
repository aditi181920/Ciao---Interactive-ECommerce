import 'dart:math';

import 'package:app1/ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';
import '../providers/user_detail.dart';
import '../services/loginuser.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override


  Widget build(BuildContext context) {

    UserModel? loggedInUser=Provider.of<UserProvider>(context,listen: false).user;
    List<ProdModel> fetchitem=[];
    FireCloud().out(loggedInUser).then((List<ProdModel> res){
      setState(() {
        print('length of result');
        print(res.length);
        fetchitem=res.map((e) => e).toList();
      });
    });
    print('count of products in the cart is\n');
    print(fetchitem.length);

    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        child:GridView.builder(
            padding:EdgeInsets.all(80.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2/2.5,
                crossAxisSpacing: 80,
                mainAxisSpacing: 80
            ),
            itemCount: fetchitem.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  fetchitem[index].image1!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // color: Colors.amber,
                          // borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(fetchitem[index].name!,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,

                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: ()async {
                  // Navigator.push(context, MaterialPageRoute(builder:(context)=>CatScreen(item:fetchitem)),
                  //
                  // );
                },
              );
            }),
      ),
    );
  }
}
