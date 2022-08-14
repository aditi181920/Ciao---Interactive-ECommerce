
import 'package:app1/providers/user_detail.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/home.dart';
import 'package:app1/ui/signup.dart';
import 'package:app1/ui/singinp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){     //if device is web
    await Firebase.initializeApp(
      options:  const FirebaseOptions(
          apiKey: "AIzaSyDXeALJdyQNG0YDN0N3U6yUB7EV-PmYBKM",
          authDomain: "test-e0085.firebaseapp.com",
          projectId: "test-e0085",
          storageBucket: "test-e0085.appspot.com",
          messagingSenderId: "810350225377",
          appId: "1:810350225377:web:f53cd2305de4e6343854a0",
          measurementId: "G-ZPBBNV5EYS",
      )
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create:(_)=>UserProvider())
      ],
      child: MaterialApp(
        title: 'Ciao',
       // theme: new ThemeData(scaffoldBackgroundColor:Colors.black),
        debugShowCheckedModeBanner: false,
        //home: SignInPage(),
        //for persistent login do
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const BottomBar();
                //return const SellScreen();
              } else {
                return const SignInPage();
              }
            }),
      ),
    );
  }
}





//
// void main() =>runApp(MaterialApp(
//   home: CiaoHome(),
// ));
//
// class CiaoHome extends StatelessWidget {
//   const CiaoHome({Key? key}) : super(key: key);
//
//   @override
//
//   }
// }
//
//
// class TestClass extends StatefulWidget {
//   const TestClass({Key? key}) : super(key: key);
//
//   @override
//   State<TestClass> createState() => _TestClassState();
// }
//
// class _TestClassState extends State<TestClass> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
