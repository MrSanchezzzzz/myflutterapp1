
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/bottom_app_bar_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinInputWidget extends StatefulWidget{
  @override
  PinInputWidgetState createState()=>PinInputWidgetState();
  PinInputWidget(String PhoneNumber,this.onTapCallBack){
    pin=getPin();
    phoneNumber=PhoneNumber;
  }
  Function onTapCallBack;
  String phoneNumber="";
  bool enabled=false;
  String pin="";
  String getPin(){
    //TODO: Implement getPin() method, which will ask server to generate new pin and send it to user
    return "1111";
  }
}
class PinInputWidgetState extends State<PinInputWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width-50,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Colors.white70,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Ми надіслали пін-код на ваш номер телефону. Щоб підтвердити його. Будь-ласка, введіть його",style: TextStyle(fontSize: 18),),
              ),
              PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                onChanged: (value){setState(() {
                  widget.enabled=value==widget.pin;
                });
                },
              ),
              Spacer(),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: RichText(
                    text:TextSpan(children:[
                      TextSpan(text: "Не отримали код? ",style: TextStyle(color:Colors.black)),
                      TextSpan(text:"Відправити повторно",
                          style: TextStyle(color:Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap=(){resendPin();}
                      )
                    ]),
                  )
                ),
              ),
              BottomAppBarButton("Далі",buttonEnabled: widget.enabled,onTapHandler: (){widget.onTapCallBack();},),
            ],
          ),
        ),
      );
  }

  void resendPin() {

  }

}