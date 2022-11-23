import 'package:app1/model/user_model.dart';
import 'package:app1/providers/user_detail.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/productscreen.dart';
import 'package:app1/ui/singinp.dart';
import 'package:app1/ui/widgets/crousal.dart';
import 'package:app1/ui/widgets/crousalhome.dart';
import 'package:app1/ui/widgets/product.dart';
import 'package:app1/ui/widgets/search_bar.dart';
import 'package:app1/ui/widgets/stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';

class extract {
  Future<List<ProdModel>> getit() async {
    //so set state
    print('getting top deals');
    List<ProdModel> pp = await FireCloud().getAllData();
    pp.sort((a, b) {
      double r1 = a.tot!;
      double r2 = b.tot!;
      double c1 = a.cntu!;
      double c2 = b.cntu!;
      String rat1 = (c1 == 0) ? 0.toString() : (r1 / c1).toString();
      String rat2 = (c2 == 0) ? 0.toString() : (r2 / c2).toString();
      return (rat1).compareTo(rat2);
    });
    print('obtained top deals');
    print(pp.length);
    return pp;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProdModel> pp = [];
  @override
  void initState() {
    super.initState();
    ret();
  }

  ret() async {
    extract obj = extract();
    pp = await obj.getit();
    if (mounted) {
      //this check is required because when we are calling future the objects will get disposed of till future completes so to stop this exception to happen do this
      setState(() {});
    }
    // setState(() {
    //  // pp=ppp;
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('final pp size:');
    print(pp.length);
    final UserModel loggedInUser =
        Provider.of<UserProvider>(context, listen: false).user;
    print('${loggedInUser.name}');
    final List<String> c1images = [
      // 'assets/limite edition/1.webp',
      // 'assets/limite edition/4.webp',
      'assets/limite edition/2.jpg',
      'assets/limite edition/3.jpg',
      'assets/limite edition/5.jpg',
      // 'assets/limite edition/7.jpg',
      'assets/limite edition/8.jpg',
    ];
    final List<ProdModel> pdet = [
      ProdModel(
          name: 'Realme 9 Pro+ | Free Fire | Limited Edition',
          description:
              "Sony IMX766 OIS Camera\nOptical and electronic image stablization\nMediaTek Dimensity 920 5G Processor\n9% faster GPU & 35% more powerful ISP\n60W SuperDart Charge\n50% charge around 15 mins*\n90Hz Super AMOLED Display\nIn-display fingerprint\nVapor Chamber Cooling System\nUp to 10°C reduction in core temperature\nDolby Atmos Dual Stereo Speakers\nX-axis linear motor",
          quantity: 50,
          price: 30,
          id: '50',
          image1: 'assets/prod/p5_1.png',
          image2: 'assets/prod/p5_2.jpg'),
      ProdModel(
          name: 'Coca-Cola® Zero Sugar Byte Limited Edition Specialty Box',
          description:
              'Inspired by gaming, Coca-Cola® Zero Sugar Byte invites you to explore what pixels might taste like with the refreshingly new, yet deliciously familiar, Coke flavor experience.\nEach limited edition specialty box includes:\n2 x 12oz Coca-Cola® Zero Sugar Byte cans\n1 Coca-Cola® Byte sticker\nAccess to AR Game',
          quantity: 50,
          price: 10,
          id: '50',
          image1: 'assets/prod/p6_1.jpg',
          image2: 'assets/prod/p6_2.jpg'),
      ProdModel(
          name: 'Limited Edition Watches: 150 Exclusive Modern Designs',
          description:
              "Welcome to a celebration of alternatively designed wrist- and pocket watches, which honors innovative craftsmanship within the world of modern horology. The 150 different brands featured in this unique book each have a double-page spread dedicated to rare, specially selected timepieces. Featured manufacturers include Patek Philippe, Jaeger LeCoultre, Vacheron Constantin, Chopard, Tag Heuer, and Hublot. There is also a broad selection of avant-garde watchmakers like MB & F, Urwerk, and DeBethune. The design and technical information of each watch, ranging from simple to elaborate, is described in this lavish showcase of mostly high-end watch brands. A wristwatch made entirely of wooden parts, a timepiece designed after a Ferrari engine, and other one-of-a-kind movements, are just a few examples of the stunning variety of alternatively conceived men's and unisex watches. Many have not appeared in print before. This collection should appeal to both watch lovers and aficionados of good design.",
          quantity: 50,
          price: 35,
          id: '50',
          image1: 'assets/prod/p7_1.jpg',
          image2: 'assets/prod/p7_2.jpg'),
      ProdModel(
          name: 'Chanel No.5 Eau De Parfum 100ml Limited Edition Red Bottle',
          description:
              'Classified as a refined, gentle and floral fragrance With feminine scent possesses a blend of modern floral, and balanced notes It is recommended for eveningwear\nDelivered within 1-2 weeks',
          quantity: 50,
          price: 200,
          id: '50',
          image1: 'assets/prod/p8_2.jpg',
          image2: 'assets/prod/p8_2.jpg'),
    ];
    return Scaffold(
      //appbar
      appBar: AppBar(
        toolbarHeight: 130,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi  ${loggedInUser.name}',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          //Text('Hi  Aditi',style:GoogleFonts.aBeeZee( textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          height: 3,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Text(
                      'Welcome back',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 700,
                height: 10,
              ),
              SearchBar(),
            ],
          ),
        ),
        //forappbar background
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
      ),
      //below appbar
      body: Container(
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          controller:
              ScrollController(), //necessary to use this controller otherwise multiple scroll views available exception is raised
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CrousalHome(images: c1images, det: pdet),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0)),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Deals of the day',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1 / 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: pp.length,
                (BuildContext context, int id) {
                  return GestureDetector(
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: Container(
                          height: 200,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(pp[id].image1!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  child: Text(
                                    '${pp[id].name}',
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
                                        text: '\$${pp[id].price}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      TextSpan(
                                        text: '   \$${pp[id].sellprice}   ',
                                        style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: Provider.of<UserProvider>(context,
                                                listen: false)
                                            .setoff(pp[id]),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 1.0,
                                      letterSpacing: 1.0,
                                      fontSize: 14.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'In stock  ${pp[id].quantity}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Stars(rating: (pp[id].avgrat), sz: 20),
                                // Stars(rating: 2.0, sz: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(p: pp[id])));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
//create a logout button and do logout (context) in onpressed

}
