
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/bottom_app_bar_button.dart';

class LoginInputWidget extends StatefulWidget{
  LoginInputWidget(this.loginCallback,{Key? key}) : super(key: key);

  @override
  LoginInputWidgetState createState()=>LoginInputWidgetState();

  Function(String) loginCallback;
  bool enabled=false;
  String login="";

}
class LoginInputWidgetState extends State<LoginInputWidget>{
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
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ваш логін",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
               ValidateInput(value);
              },
              onChanged: onTextChanged,
            ),
            Spacer(),
            BottomAppBarButton("Зареєструватись",buttonEnabled: widget.enabled,onTapHandler: (){widget.loginCallback(widget.login);},)
          ],
        ),
      ),
    );
  }
  onTextChanged(String value){
    setState((){widget.enabled=ValidateInput(value)==null;});
  }
  String? ValidateInput(value){
    if(value!.isEmpty||value==null)
      return "Поле не має бути порожнім";
    else if(!(RegExp("^[a-zA-Z0-9_]*\$").hasMatch(value)))
      return "Латиниця, цифри і підкреслення(_)";
    else if(value.contains(" "))
      return "Без пробілів";
    else if(value.length<4)
      return "Мінімум 4 символа";
    return null;
  }
}