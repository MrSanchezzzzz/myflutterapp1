
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myflutterapp1/alert_dialog.dart';
import 'package:myflutterapp1/Widgets/auth/auth_button.dart';
import 'package:myflutterapp1/Widgets/auth/auth_containers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myflutterapp1/Widgets/bottom_app_bar_button.dart';

class PhoneInputWidget extends StatefulWidget{
  @override
  PhoneInputWidgetState createState()=>PhoneInputWidgetState();
  bool buttonEnabled=false;
  late String phoneNumber;
  PhoneInputWidget(this.callback,{String Phone="+38"}){
    phoneNumber=Phone;
  }

  //This callback is used to return phone number to parent widget
  Function(String) callback;
}

class PhoneInputWidgetState extends State<PhoneInputWidget> {
 late TextEditingController _controller;

  @override
  void initState(){
    _controller=TextEditingController();
    _controller.text=widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return AuthBottomContainer(
        Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top:15, left: 15, right: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Viaoda Libre",
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Icon(Icons.language, color: Colors.black,)
                      ),
                      hintText:"+380 97 661 82 83"
                  ),
                  controller: _controller,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '+38# ## ### ## ##', filter: { "#": RegExp(r'[0-9]') })
                  ],
                  onChanged: (value){
                    widget.phoneNumber=value;
                    },
                  onTap: (){
                    if(_controller.text==""){
                      _controller.text+="+38";
                      setState(() {});
                    }
                  },

                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 115,vertical: 25),
              child: AuthButton("??????i",fontSize: 24,onTap:() {
                if(ValidatePhoneInput(widget.phoneNumber)){
                  widget.callback(widget.phoneNumber);
                }
                else{
                  MyAlertDialog.showAlertDialog(context,"????????-??????????, ????????i???? ?????????????????? ??????????, ?????? ????????????????????");
                }
              },
              ),
            )
          ],
        )
    );
  }


  ///Checks if phone is correct. Enables button if true
  bool ValidatePhoneInput(String? value) {
    if (value == null || value.isEmpty) {
      return  false;
    }
    else if (!(RegExp("([+ 0-9])\\w+").hasMatch(value))) {
      return false;
    }
    else if (value.length!=17){
      return false;
    }
    return true;
  }


}
