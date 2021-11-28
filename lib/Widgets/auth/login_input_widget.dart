
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/auth/auth_containers.dart';

import 'auth_button.dart';

class LoginInputWidget extends StatefulWidget{
  LoginInputWidget(this.nextCallback,this.backCallback,{String login=""}){
    _login=login;
  }

  @override
  LoginInputWidgetState createState()=>LoginInputWidgetState();
  Function(String) backCallback;
  Function(String) nextCallback;
  bool nextAllowed=false;
  late String _login;

}
class LoginInputWidgetState extends State<LoginInputWidget>{
  late TextEditingController _controller;

  @override
  void initState(){
    super.initState();
    _controller=TextEditingController();
    _controller.text=widget._login;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: AuthTopContainer(
            Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Телефонний номер підтверджено.\nДля завершення реєстрації введіть свій логін",style: TextStyle(
              fontSize: 20,
              fontFamily: "Viaoda Libre",
            ),
              textAlign: TextAlign.center,
            ),
          ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AuthBottomContainer(
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Viaoda Libre",
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        hintText: "Введіть ваш логін",
                      ),
                      onChanged: onTextChanged,
                      controller: _controller,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Align(
                      alignment: Alignment.centerLeft,

                      child: AuthButton("Назад",fontSize: 24,onTap:(){ widget.backCallback(widget._login);},),
                    ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AuthButton("Далi",
                          fontSize: 24,
                          enabled: widget.nextAllowed,
                          onTap: (){widget.nextCallback(widget._login);},
                        ),
                      ),
                      ]
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  onTextChanged(String value){
    widget._login=value;
    setState((){widget.nextAllowed=ValidateInput(value);});
  }
  bool ValidateInput(value){
    if(value!.isEmpty||value==null)
      return false;
    else if(!(RegExp("^[a-zA-Z0-9_]*\$").hasMatch(value)))
      return false;
    else if(value.contains(" "))
      return false;
    else if(value.length<4)
      return false;
    return true;
  }
}