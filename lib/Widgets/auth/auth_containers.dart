
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthBottomContainer extends StatelessWidget{
  Widget child;
  AuthBottomContainer(this.child);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        )
        ),
        child:Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width/8,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  color: Color(0xff808080),
                ),
                alignment: Alignment.topCenter,
              ),
            ),
          child,
        ],)
      ),
    );
  }
}

class AuthTopContainer extends StatelessWidget{
  Widget _child;
  double? _maxHeight;
  double? _maxWidth;
  AuthTopContainer(this._child,{double? maxHeight,double? maxWidth}){
    _maxHeight=maxHeight;
    _maxWidth=maxWidth;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height/8,
          minWidth: MediaQuery.of(context).size.width/8,
          maxHeight: _maxHeight?? MediaQuery.of(context).size.height/4,
          maxWidth:_maxWidth?? double.infinity
        ),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: _child,
      ),
    );
  }

}