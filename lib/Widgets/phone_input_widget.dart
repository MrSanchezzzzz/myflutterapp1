
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/bottom_app_bar_button.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneInputWidget extends StatefulWidget{
  @override
  PhoneInputWidgetState createState()=>PhoneInputWidgetState();
  bool buttonEnabled=false;
  String phoneNumber="";
  PhoneInputWidget(this.callback);

  //This callback is used to return phone number to parent widget
  Function(String) callback;
}

class PhoneInputWidgetState extends State<PhoneInputWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:15),
        width: MediaQuery.of(context).size.width-50,
      height: 225,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Colors.white70,
      ),

        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text("Введіть ваш номер телефона, щоб ми могли підтвердити вашу особу",textScaleFactor: 1.25),
          ),
           Padding(padding: EdgeInsets.all(10),
            child: PhoneFormField(
          defaultCountry: "UA",
          selectorNavigator: DraggableModalBottomSheetNavigator(),
              validator: PhoneValidator.compose([
                PhoneValidator.validMobile(errorText: "Введіть коректний номер",allowEmpty: false)]),
              onChanged: ValidatePhoneInput,
              decoration: InputDecoration(labelText: "Ваш номер телефону"),
        )
      ),
            Spacer(),
            BottomAppBarButton("Далі",
              buttonEnabled: widget.buttonEnabled,
              onTapHandler: onButtonTap,
            )
      ],
        )
      );
  }
  onButtonTap(){
    widget.callback(widget.phoneNumber);
    print("phone tap");
  }
  ///Checks if phone is correct. Enables button if true
  void ValidatePhoneInput(PhoneNumber? value){
    if (value != null) {
      if(value.nsn.isNotEmpty&&value.validate(type: PhoneNumberType.mobile)){
        widget.buttonEnabled=true;
        widget.phoneNumber=value.isoCode+value.nsn;
      }
    }
    setState(() {});
  }
}