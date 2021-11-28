
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTopContainerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/5,maxWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(color:Color(0xff4D662D)),
      child: Padding(
        padding: const EdgeInsets.only(top: 35,bottom: 4,left: 28,right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8,top: 8),
                    child: Text("Chang",style: TextStyle(fontSize: 40,color:Color(0xffD1D5DB)),)),
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-98),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF6F6F6),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Введiть назву страви",
                      contentPadding: EdgeInsets.only(left:25),
                      focusColor:Colors.transparent,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.transparent,width: 0))
                    ),
                    style: TextStyle(fontFamily: "Viaoda Libre"),
                    onChanged: (value) {
                    },
                  ),
                ),
              ],
            ),
            Image(image: AssetImage("assets/images/A_logo-01.png"),)
          ],
        ),
      ),
    );
  }

}