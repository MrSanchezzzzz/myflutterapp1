
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/auth_containers.dart';
import 'package:myflutterapp1/Widgets/bottom_app_bar_button.dart';

import 'auth_button.dart';

class LoginInputWidget extends StatefulWidget{
  LoginInputWidget(this.loginCallback,this.backCallback,{Key? key}) : super(key: key);

  @override
  LoginInputWidgetState createState()=>LoginInputWidgetState();
  Function() backCallback;
  Function(String) loginCallback;
  bool nextAllowed=false;
  String login="";

}
class LoginInputWidgetState extends State<LoginInputWidget>{
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
          ),),
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
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Align(
                      alignment: Alignment.centerLeft,

                      child: AuthButton("Назад",fontSize: 24,onTap: widget.backCallback,),
                    ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AuthButton("Далi",
                          fontSize: 24,
                          enabled: widget.nextAllowed,
                          onTap: (){widget.loginCallback(widget.login);},
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
    widget.login=value;
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