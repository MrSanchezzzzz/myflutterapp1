
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
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(color: enabled?Colors.green:Colors.grey,borderRadius: BorderRadius.all(Radius.circular(20))),
        width: double.infinity,
          child: TextButton(
            onPressed:enabled?onTap:null,
              child: Text(text,style: TextStyle(color:Colors.white),)
           ),
    );
  }

}