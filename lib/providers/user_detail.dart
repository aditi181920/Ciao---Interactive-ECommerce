
import 'package:app1/model/cart_model.dart';
import 'package:app1/model/user_model.dart';
import 'package:app1/services/loginuser.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class UserProvider with ChangeNotifier{
  UserModel user;
  List<ProdModel> cart;
  List<ProdModel> wish;
  UserProvider()
      : user = UserModel(uid: "loading",email: "loading",password: "loading", address: "Loading",name: "loading", rating: 'loading')
       , cart= []
       , wish=[];
  Future getData() async{
    user=await FireCloud().getData();
    notifyListeners();
    // print('updating to current user');
    // print(user);
    // print('getting cart data ');
    cart=await FireCloud().getCart();
    notifyListeners();
    wish=await FireCloud().getWish();
    // print('cart length is');
    // print(cart.length);
    // print('wish list length is ');
    // print(wish.length);
    notifyListeners();
  }
  List<ProdModel> get Cart=> cart;
  List<ProdModel> get Wish=>wish;
  void setCart(ProdModel prod){
    //we need to check if this same id product exists
    FireCloud().addProductToCart(productModel: prod);
    notifyListeners();
  }
  void setWishlist(ProdModel prod){
    //we need to check if this same id product exists
    FireCloud().addProductToWish(productModel: prod);
    notifyListeners();
  }
  void delFromCart(ProdModel prod){
    FireCloud().deleteProductFromCart(uid: prod.id!);
    notifyListeners();
  }
  String setoff(ProdModel prod){
    prod.off=0;
    // print('printing values for discount');
    // print('printing values for price');
    // print(prod.price);
    // print('printing values for selling price');
    // print(prod.sellprice);
    print('quantity of current product is');
    print(prod.quantity);
    if(((prod.price)!=null) && ((prod.sellprice)!=null)) {
      //print('entering ');
      prod.off = (((((prod.price) )! - ((prod.sellprice))!)*100) /
          ((prod.sellprice)!)) ;
    }
    String offer=prod.off!.toStringAsFixed(1);
    offer+='%';
    offer+=' off';
    if((prod.tot==null)||(prod.cntu==null) ||(prod.cntu==0))prod.avgrat=0;
    else prod.avgrat=((prod.tot)!/(prod.cntu)!);
  //  notifyListeners();
    // print('printing avg');
    // print(prod.avgrat);
      return offer;
  }
  // double avgrating(ProdModel prod){
  //
  //   return prod.avgrat!;
  // }

}