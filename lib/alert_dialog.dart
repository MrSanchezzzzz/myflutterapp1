
import 'package:flutter/material.dart';

import 'Widgets/bottom_app_bar_button.dart';

class MyAlertDialog{
  static Future<void> showAlertDialog(BuildContext context,String text)async {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width/4,
          height: MediaQuery.of(context).size.height/5.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(text,
                  style: TextStyle(fontFamily: "SEOULHANGANG CBL"),
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomAppBarButton("ОК",onTapHandler: (){Navigator.of(context).pop();},),
              )
            ],
          ),
        ),
      );
    });
  }
}