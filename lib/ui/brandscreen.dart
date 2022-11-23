import 'package:animated_dashed_circle/animated_dashed_circle.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/storyscreen.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/brand.dart';
import '../model/story.dart';

class brandPage extends StatefulWidget {
  const brandPage({Key? key}) : super(key: key);

  @override
  State<brandPage> createState() => _brandPageState();
}

class _brandPageState extends State<brandPage>
{
  List<Brand> allbrand = [];
  List<List<Story>> stories = [];
  late Animation gap;
  late Animation<double> base;
  late Animation<double> reverse;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    getallbrand();
    getallstory();
    // controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 60));
    // base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    // reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    // gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // controller.forward();
  }


  void getallbrand() async {
    allbrand = await FireCloud().retBrand();
    if (mounted) setState(() {});
  }

  void getallstory() async {
    stories = await FireCloud().retstories();
    print('final stories size');
    print(stories.length);
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  // @override
  // void dispose() {
  //   //controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
   // super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 60,
      //   title: Padding(
      //     padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
      //     child: Text('Halo',
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.blue.withOpacity(0.5),
      // ),
      backgroundColor: Colors.transparent,
      body: GridView.builder(
        controller: ScrollController(),
        itemCount: allbrand.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1 / 1),
        itemBuilder: (BuildContext context, int id) {
          return Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Stack(
              children:<Widget>[
                AnimatedDashedCircle().show(
                image: AssetImage(
                  allbrand[id].profileImageUrl,
                ),
                autoPlay: true,
                duration: Duration(seconds: 60),
                height: 250,
                borderWidth: 5,
                imageBgColor: Colors.transparent,
              ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => storyScreen(
                              b: allbrand[id], st: stories[id])),
                    );
                  },
                ),
                ]

            ),
          );
        },
        padding: EdgeInsets.all(45),
        shrinkWrap: true,
      ),
    );
  }
}




//
// import 'package:app1/services/loginuser.dart';
// import 'package:app1/ui/storyscreen.dart';
// import 'package:dashed_circle/dashed_circle.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../model/brand.dart';
// import '../model/story.dart';
//
// class brandPage extends StatefulWidget {
//   const brandPage({Key? key}) : super(key: key);
//
//   @override
//   State<brandPage> createState() => _brandPageState();
// }
//
// class _brandPageState extends State<brandPage>
//     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   List<Brand> allbrand = [];
//   List<List<Story>> stories = [];
//   late Animation gap;
//   late Animation<double> base;
//   late Animation<double> reverse;
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     getallbrand();
//     getallstory();
//     controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 60));
//     base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
//     reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
//     gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
//       ..addListener(() {
//         setState(() {});
//       });
//     controller.forward();
//   }
//
//
//   void getallbrand() async {
//     allbrand = await FireCloud().retBrand();
//     if (mounted) setState(() {});
//   }
//
//   void getallstory() async {
//     stories = await FireCloud().retstories();
//     print('final stories size');
//     print(stories.length);
//     if (mounted) setState(() {});
//   }
//
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // super.build(context);
//     return Scaffold(
//       // appBar: AppBar(
//       //   toolbarHeight: 60,
//       //   title: Padding(
//       //     padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
//       //     child: Text('Halo',
//       //       style: TextStyle(
//       //         fontSize: 30,
//       //         fontWeight: FontWeight.bold,
//       //       ),
//       //     ),
//       //   ),
//       //   backgroundColor: Colors.blue.withOpacity(0.5),
//       // ),
//       backgroundColor: Colors.transparent,
//       body: GridView.builder(
//         controller: ScrollController(),
//         itemCount: allbrand.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 8,
//             mainAxisSpacing: 20,
//             crossAxisSpacing: 20,
//             childAspectRatio: 1 / 1),
//         itemBuilder: (BuildContext context, int id) {
//           return Container(
//             color: Colors.transparent,
//             alignment: Alignment.center,
//             child: RotationTransition(
//               turns: base,
//               child: DashedCircle(
//                 gapSize: gap.value,
//                 dashes: 40,
//                 color: Color(0XFFED4634),
//                 child: RotationTransition(
//                   turns: reverse,
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: InkWell(
//                       child: Container(
//                         //color: Colors.transparent,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(80),
//                           color: Colors.transparent,
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage(
//                               allbrand[id].profileImageUrl,
//                             ),
//                           ),
//                         ),
//                       ),
//                       // CircleAvatar(
//                       //   backgroundColor: Colors.transparent,
//                       //   foregroundColor: Colors.transparent,
//                       //   radius: 100.0,
//                       //   backgroundImage: NetworkImage(
//                       //     allbrand[id].profileImageUrl
//                       //   ),
//                       // ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => storyScreen(
//                                   b: allbrand[id], st: stories[id])),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         padding: EdgeInsets.all(45),
//         shrinkWrap: true,
//       ),
//     );
//   }
// }
