
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget{

  String text;
  Function() onTap;
  bool? enabled;
  bool _enabled=true;
  Button({required this.text,required this.onTap,this.enabled}){
    _enabled=enabled??true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor:_enabled?MaterialStateProperty.all<Color>(Color(0xff4D662D)):MaterialStateProperty.all<Color>(Color(0xffA2A8AC)),
            foregroundColor:MaterialStateProperty.all<Color>(Color(0xffD1D5DB)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 18)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
          ),
          child: Text(text,style: TextStyle(fontSize: 17),),
        )
    );
  }

}