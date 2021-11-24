
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarButton extends StatelessWidget{
  final String text;
  Function()? onTap;
  late bool enabled;
  BottomAppBarButton(this.text,{Function()? onTapHandler, bool buttonEnabled=true}){
    onTap=onTapHandler;
    enabled=buttonEnabled;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: enabled?Color(0xff4D662D):Colors.grey,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
        ),
        width: double.infinity,
          child: TextButton(
            onPressed:enabled?onTap:null,
              child: Text(text,style: TextStyle(color:Colors.white),)
           ),
    );
  }

}