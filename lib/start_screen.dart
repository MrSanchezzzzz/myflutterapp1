
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/auth_screen.dart';

class StartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage("assets/images/start_screen_background.png"),
          fit:BoxFit.fill)
        ),
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/8,
            decoration: BoxDecoration(color:Color(0x80B8F2FF),borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text("Почати",
                  style: TextStyle(
                      color:Color(0xff29360F),
                    fontFamily: "SEOULHANGANG CBL",
                      fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));},
        ),
      )
    );
  }

}