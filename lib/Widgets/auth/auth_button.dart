
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget{
  String text;
  double? _fontSize;
  late bool _enabled;
  Function()? _onTap;
  AuthButton(this.text,{double? fontSize,bool enabled=true,Function()? onTap}){
    _fontSize=fontSize??20;
    _enabled=enabled;
    _onTap=onTap;
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(text, style:TextStyle(fontSize: _fontSize,fontFamily: "SEOULHANGANG CBL",color:_enabled?Color(0xff29360F):Colors.grey)
      ),
      onTap:_enabled?_onTap:(){},
    );
  }

}