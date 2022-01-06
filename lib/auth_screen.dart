
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/auth/login_input_widget.dart';
import 'package:myflutterapp1/Widgets/auth/phone_input_widget.dart';
import 'package:myflutterapp1/Widgets/auth/pin_input_widget.dart';
import 'package:myflutterapp1/alert_dialog.dart';
import 'package:myflutterapp1/main_screen.dart';
import 'package:path_provider/path_provider.dart';

class AuthScreen extends StatefulWidget{
  @override
  AuthScreenState createState() => AuthScreenState();

  String userPhoneNumber="";
  String userPin="";
  String userLogin="";

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
          return PinInputWidget(widget.userPhoneNumber,PinCallback,previuosStep,Pin: widget.userPin,);
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
   nextStep();
  }
  void LoginCallback(String login){
    widget.userLogin=login;
    nextStep();
  }
  void SaveLogin(String login){
    widget.userLogin=login;
    previuosStep();
  }
  void PinCallback(String pin){
    widget.userPin=pin;
    nextStep();
  }
  void nextStep(){
    setState(() {
      widget.authStage++;
    });
  }
  void previuosStep(){
    setState(() {
      widget.authStage--;
    });
  }

  Future<void> CreateUser(String login, String phoneNumber) async {
    //TODO: implement method CreateUser. It will ask server to add user to db
    final String dir= (await getTemporaryDirectory()).path;
    File f=File('$dir/eucalyptTemp.txt');
    f.writeAsString(login+"\n"+phoneNumber);
  }
}