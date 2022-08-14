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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
class extract{
   List<ProdModel> pp=[];
  Future<List<ProdModel>> getit() async{ //so set state
    print('getting top deals');
    pp=await FireCloud().getAllData();
    pp.sort((a,b){
      double r1=double.parse(a.tot!);
      double r2=double.parse(b.tot!);
      double c1=double.parse(a.cntu!);
      double c2=double.parse(b.cntu!);
      String rat1=(r1/c1).toString();
      String rat2=(r2/c2).toString();
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
  List<ProdModel> pp=[];
  @override
  void initState(){
    super.initState();
    ret();
  }
  void ret() async{
    extract obj=extract();
    List<ProdModel> ppp=await obj.getit();
    pp=ppp;
  }
  @override
  Widget build(BuildContext context) {
    print('final pp size:');
    print(pp.length);
    UserModel? loggedInUser=Provider.of<UserProvider>(context,listen: false).user;
    print('${loggedInUser.name}');
    final List<String> c1images=[
      // 'assets/limite edition/1.webp',
      // 'assets/limite edition/4.webp',
      'assets/limite edition/2.jpg',
      'assets/limite edition/3.jpg',
      'assets/limite edition/5.jpg',
     // 'assets/limite edition/7.jpg',
      'assets/limite edition/8.jpg',


    ];
    final List<ProdModel> pdet=[
      ProdModel(name:'Realme 9 Pro+ | Free Fire | Limited Edition' ,description:"Sony IMX766 OIS Camera\nOptical and electronic image stablization\nMediaTek Dimensity 920 5G Processor\n9% faster GPU & 35% more powerful ISP\n60W SuperDart Charge\n50% charge around 15 mins*\n90Hz Super AMOLED Display\nIn-display fingerprint\nVapor Chamber Cooling System\nUp to 10°C reduction in core temperature\nDolby Atmos Dual Stereo Speakers\nX-axis linear motor",quantity:'50',price:'\$30',id:'50',image1:'assets/prod/p5_1.png',image2:'assets/prod/p5_2.jpg'),
      ProdModel(name:'Coca-Cola® Zero Sugar Byte Limited Edition Specialty Box' ,description:'Inspired by gaming, Coca-Cola® Zero Sugar Byte invites you to explore what pixels might taste like with the refreshingly new, yet deliciously familiar, Coke flavor experience.\nEach limited edition specialty box includes:\n2 x 12oz Coca-Cola® Zero Sugar Byte cans\n1 Coca-Cola® Byte sticker\nAccess to AR Game' ,quantity:'50' ,price: '\$10',id:'50' ,image1: 'assets/prod/p6_1.jpg',image2:'assets/prod/p6_2.jpg' ),
      ProdModel(name: 'Limited Edition Watches: 150 Exclusive Modern Designs',description:"Welcome to a celebration of alternatively designed wrist- and pocket watches, which honors innovative craftsmanship within the world of modern horology. The 150 different brands featured in this unique book each have a double-page spread dedicated to rare, specially selected timepieces. Featured manufacturers include Patek Philippe, Jaeger LeCoultre, Vacheron Constantin, Chopard, Tag Heuer, and Hublot. There is also a broad selection of avant-garde watchmakers like MB & F, Urwerk, and DeBethune. The design and technical information of each watch, ranging from simple to elaborate, is described in this lavish showcase of mostly high-end watch brands. A wristwatch made entirely of wooden parts, a timepiece designed after a Ferrari engine, and other one-of-a-kind movements, are just a few examples of the stunning variety of alternatively conceived men's and unisex watches. Many have not appeared in print before. This collection should appeal to both watch lovers and aficionados of good design." ,quantity:'50' ,price:'\$35' ,id:'50' ,image1:'assets/prod/p7_1.jpg' ,image2:'assets/prod/p7_2.jpg'),
      ProdModel(name: 'Chanel No.5 Eau De Parfum 100ml Limited Edition Red Bottle',description:'Classified as a refined, gentle and floral fragrance With feminine scent possesses a blend of modern floral, and balanced notes It is recommended for eveningwear\nDelivered within 1-2 weeks' ,quantity:'50' ,price: '\$200',id:'50',image1:'assets/prod/p8_2.jpg' ,image2: 'assets/prod/p8_2.jpg'),
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

                    Text('Hi  ${loggedInUser.name}',style:GoogleFonts.aBeeZee( textStyle: TextStyle(
                    //Text('Hi  Aditi',style:GoogleFonts.aBeeZee( textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      height: 3,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    ),
                    ),

                    Text('Welcome back',style:GoogleFonts.aBeeZee(textStyle: TextStyle(
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

              )
              ,
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
        child:CustomScrollView(
          slivers:<Widget> [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CrousalHome(images:c1images,det:pdet),

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
                // crossAxisSpacing: 20.0,
                //mainAxisSpacing: 20.0,
              ),

              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                  (BuildContext context, int index){

                    return GestureDetector(
                      child: Container(
                        child: Padding(padding:EdgeInsets.all(30),
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 10.0,20.0, 80.0),
                                    child: Product(p:pp[index])))),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>ProductPage(p:pp[index])));
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
//bonus persist changes of login



