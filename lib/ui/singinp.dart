import 'package:app1/services/firebaseser.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/ui/home.dart';
import 'package:app1/ui/signup.dart';
import 'package:app1/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//since we will use text feild which wll change dynamicaly so use stateful widget
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //definitions required to create form
  final _formKey = GlobalKey<FormState>(); //global key can access the states of wigets  specified with global key
  final TextEditingController _emailcontroller=new TextEditingController(); //textediting controller are used to listent to the changes made by user in text fiels and notify the listners so the changes can be updated on the screen
  final TextEditingController _passwordcontroller=new TextEditingController();
  final _auth =FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailcontroller,
      validator: (value){
        if(value!.isEmpty){
          return ('Please enter your email');
        }
        //reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ('Please enter a valid email');
        }
        return null;
      },
      onSaved: (value){
        _emailcontroller.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: _passwordcontroller,
      obscureText: true,
      validator: (value){
        RegExp regex=new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return('Please enter your password');
        }
        if(!regex.hasMatch(value)){
          return('Too short password(Min. 6 required)');
        }
        return null;
      },
      onSaved: (value){
        _passwordcontroller.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.all(5.0),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: Colors.deepPurple[300],
      child: MaterialButton(
        padding: EdgeInsets.all(20.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()async{
          if(_formKey.currentState!.validate()){
            String out= await FireServ().signIn(email:_emailcontroller.text, password:_passwordcontroller.text);
            if(out=="success"){
               Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context){
                    return BottomBar();
                  },
                  ),
                   (route) => false);
            }
              else{
                Utils().showSnackBar(context: context, content: out);
            }
          }

        },
        child: Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );

    //creating container which defines our page
    return Container(
      //background image
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
          image: AssetImage("assets/hand.jpg",
            ),
          fit: BoxFit.cover,
        ),
      ),
      //scaffold is required for using textformfield
      child: Padding(
        padding: EdgeInsets.fromLTRB(800.0,0.0,0.0,0.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(

            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 80.0, right: 80.0),
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Image.asset(
                            'assets/logo2.png',
                            fit: BoxFit.contain,

                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        emailField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30.0,
                        ),
                        passwordField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                        ),
                        loginButton,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>
                                            SignUpPage()
                                    ),
                                );
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // void signIn(String email,String password) async{
  //   //if the validation is okay
  //   if(_formKey.currentState!.validate()){
  //     try{
  //          await _auth
  //          .signInWithEmailAndPassword(email: email, password: password)
  //          .then((uid) =>
  //          {
  //            //if login is successful then pass uid
  //            Fluttertoast.showToast(msg: 'Login successful'),
  //            Navigator.of(context).pushAndRemoveUntil(
  //            MaterialPageRoute(builder: (context) => BottomBar(),),
  //            (route) => false)
  //          }
  //        );
  //     }on FirebaseAuthException catch(e){
  //       Fluttertoast.showToast(msg: e.code);
  //       print(e.code);
  //     }
  //   }
  // }
}


