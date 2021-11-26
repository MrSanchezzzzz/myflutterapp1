
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/login_input_widget.dart';
import 'package:myflutterapp1/Widgets/phone_input_widget.dart';
import 'package:myflutterapp1/Widgets/pin_input_widget.dart';
import 'package:myflutterapp1/alert_dialog.dart';
import 'package:myflutterapp1/main_screen.dart';

class AuthScreen extends StatefulWidget{
  @override
  AuthScreenState createState() => AuthScreenState();

  String userPhoneNumber="";
  String userPin="";
  String userLogin="";

  //TODO: return to zero
  int authStage=0;
}

class AuthScreenState extends State<AuthScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/auth_screen_background.png"),fit: BoxFit.fill)
        ),
        child: Container(child: selectAuthWidget(widget.authStage)
        ),
      ),
    );
  }
  Widget selectAuthWidget(int stage){
    switch (stage){
      case 0:
        return PhoneInputWidget(PhoneNumberCallback,Phone: widget.userPhoneNumber);
        break;
      case 1:
          return PinInputWidget(widget.userPhoneNumber,PinCallback,previuos,Pin: widget.userPin,);
        break;
      case 2:
        return LoginInputWidget(LoginCallback,SaveLogin,login: widget.userLogin,);
        break;
      case 3:
        CreateUser(widget.userLogin,widget.userPhoneNumber);



        Timer(
            const Duration(seconds: 1),
                () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen())));
        break;
    }

    return Container();
  }

  void PhoneNumberCallback(String phoneNumber){
   widget.userPhoneNumber=phoneNumber;
   next();
  }
  void LoginCallback(String login){
    widget.userLogin=login;
    next();
  }
  void SaveLogin(String login){
    widget.userLogin=login;
    previuos();
  }
  void PinCallback(String pin){
    widget.userPin=pin;
    next();
  }
  void next(){
    setState(() {
      widget.authStage++;
    });
  }
  void previuos(){
    setState(() {
      widget.authStage--;
    });
  }

  void CreateUser(String login, String phoneNumber) {
    //TODO: implement method CreateUser. It will ask server to add user to db
  }
}