import 'dart:math';

import 'package:app1/model/user_model.dart';
import 'package:app1/services/firebaseser.dart';
import 'package:app1/services/loginuser.dart';
import 'package:app1/ui/bottom_bar.dart';
import 'package:app1/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _namecontroller=new TextEditingController();
  final _emailcontroller=new TextEditingController();
  final _passwordcontroller=new TextEditingController();
  final _passwordconfirmcontroller=new TextEditingController();
  final _addresscontroller = new TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _passwordconfirmcontroller.dispose();
    _namecontroller.dispose();
    _addresscontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //firstnamefield
    final firstnameField = TextFormField(
      autofocus: false,
      controller: _namecontroller,
      validator: (value){
        _namecontroller.text.trim();
        RegExp regex=new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return('Please enter your firstname');
        }
        if(!regex.hasMatch(value)){
          return('Too short password(Min. 3 required)');
        }
        return null;
      },
      onSaved: (value){
        _namecontroller.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'First name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailcontroller,
      validator: (value){
        _emailcontroller.text.trim();
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
        _passwordcontroller.text.trim();
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
      textInputAction: TextInputAction.next,
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

    //confirm passwordfield
    final passwordConfirmField = TextFormField(
      autofocus: false,
      controller: _passwordconfirmcontroller,
      obscureText: true,
      validator: (value){
        _passwordconfirmcontroller.text.trim();
        if(_passwordcontroller.text!=_passwordconfirmcontroller.text){
          return("Passwords don't match");
        }
        return null;
      },
      onSaved: (value){
        _passwordconfirmcontroller.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final addressField = TextFormField(
      autofocus: false,
      controller: _addresscontroller,
      validator: (value){
        _addresscontroller.text.trim();
        if(value!.isEmpty){
          return('Please enter your address');
        }
        return null;
      },
      onSaved: (value){
        _addresscontroller.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.home_outlined),
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'Address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final SignUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: Colors.deepPurple[300],
      child: MaterialButton(
        padding: EdgeInsets.all(20.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()async{
          if(_formKey.currentState!.validate()) {
            String out=await FireServ().signUp(
                name: _namecontroller.text,
                email:_emailcontroller.text,
                password:_passwordcontroller.text,
                address:_addresscontroller.text,
            );
            if(out=="success"){
              //signupsuccessfull
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context){
                    return BottomBar();
                  },
                  ),
                      (route) => false);

            }else{
              Utils().showSnackBar(context:context,content:out);
            }
          }else {
            Utils().showSnackBar(context:context,content:'validation falied');
          }
         // signUp(_emailcontroller.text, _passwordcontroller.text);
        },
        child: Text("SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );

    return Container(
      //background image
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
          image: AssetImage("assets/hand.jpg"),
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
                color: Colors.transparent,
                margin: const EdgeInsets.only(left: 80.0, right: 80.0),
                child: Padding(
                  padding: EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset(
                            'assets/2.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        firstnameField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),
                        emailField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),
                        passwordField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),
                        passwordConfirmField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),
                        addressField,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),
                        SignUpButton,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                        ),

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
}


