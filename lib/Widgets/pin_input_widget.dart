
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/auth_button.dart';
import 'package:myflutterapp1/Widgets/auth_containers.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinInputWidget extends StatefulWidget{

  @override
  PinInputWidgetState createState()=>PinInputWidgetState();
  PinInputWidget(String PhoneNumber,this.onNextCallback,this.onBackCallback,{String Pin=""}){
    correctPin=getPin();
    phoneNumber=PhoneNumber;
    pin=Pin;
    nextAllowed=pin==correctPin;
  }
  //Callback functions to change auth stage
  Function() onBackCallback;
  Function(String) onNextCallback;

  String phoneNumber="";
  bool nextAllowed=false;
  late String pin;

  String correctPin="";
  String getPin(){
    //TODO: Implement getPin() method, which will ask server to generate new pin and send it to user
    return "1111";
  }
}
class PinInputWidgetState extends State<PinInputWidget>{
  late TextEditingController _controller;

  @override
  void initState(){
    _controller=TextEditingController();
    _controller.text=widget.pin;
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
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Код авторизацiї відправлено на Ваш телефон",style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Viaoda Libre",
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 1,color: Color(0xffEBEBEB)))
                    ),
                    child: InkWell(
                      child: Text("Запросити код повторно",textAlign: TextAlign.center, style:TextStyle(fontSize: 24,fontFamily: "SEOULHANGANG CBL",color:Colors.blue)
                      ),
                      onTap:(){
                        //TODO: resend PIN;
                      },
                    ),
                  ),
                )
              ],),
            ),
            maxHeight: MediaQuery.of(context).size.height/6,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AuthBottomContainer(
            Padding(
              padding: const EdgeInsets.only(top:30,left: 25,right: 25),
              child: Column(children: [
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  keyboardType: TextInputType.number,
                  onChanged: (value){setState(() {
                    widget.nextAllowed=value==widget.correctPin;
                  });
                  },
                  controller: _controller,
                  pinTheme: PinTheme(
                    activeColor: Colors.black,
                    selectedColor: Colors.black,
                    inactiveColor: Colors.black,
                  ),
                  textStyle: TextStyle(
                    fontFamily: "SEOULHANGANG CBL"
                        ""
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: AuthButton("Назад",
                        fontSize: 24,
                        onTap: widget.onBackCallback,),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(child: AuthButton("Далi",
                        enabled: widget.nextAllowed,
                          fontSize: 24,
                          onTap: (){widget.onNextCallback(widget.correctPin);} ,
                      ),
                        alignment: Alignment.centerRight,

                      ),
                    ],
                  ),
                ),
              ],
              ),
            )
            ),
        ),
      ],
    );
  }
}
