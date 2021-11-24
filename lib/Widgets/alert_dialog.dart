
import 'package:flutter/material.dart';

import 'bottom_app_bar_button.dart';

class MyAlertDialog{
  static Future<void> showAlertDialog(BuildContext context)async {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width/4,
          height: MediaQuery.of(context).size.height/6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Будь-ласка, введiть коректний номер, щоб продовжити",
                  style: TextStyle(fontFamily: "SEOULHANGANG CBL"),
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
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