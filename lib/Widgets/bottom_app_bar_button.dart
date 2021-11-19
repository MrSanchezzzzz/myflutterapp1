
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarButton extends StatelessWidget{
  final String text;
  Function()? onTap;
  BottomAppBarButton(this.text,{Function()? onTapHandler}){
    onTap=onTapHandler;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(20))),
        width: double.infinity,
          child: TextButton(
            onPressed: onTap,
              child: Text(text,style: TextStyle(color:Colors.white),)
           ),
    );
  }

}