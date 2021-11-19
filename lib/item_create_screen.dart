
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Widgets/bottom_app_bar_button.dart';

class ItemCreateScreen extends StatefulWidget{
  @override
  ItemCreateScreenState createState() => ItemCreateScreenState();

}
class ItemCreateScreenState extends State<ItemCreateScreen>{

   String title="";
   String description="";
   ImageProvider image=AssetImage("assets/images/empty_plate.jpg");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Додавання страви")),
      body: Padding(
        padding: EdgeInsets.only(top:15,left:15,right: 15),
        child: Column(children: [
          InkWell(
            child:Column(children:[
            ClipOval(
              child:
                Image(
                image:image,
                width: 250,
                height: 250,
                fit:BoxFit.cover,
                ),
            ),
              Align(child:
              Icon(Icons.add_a_photo),
                alignment: Alignment.centerRight,
                ),
              ]
            ),
            onTap: () async{
              ImagePicker picker=ImagePicker();
              XFile? file=await picker.pickImage(source: ImageSource.gallery);
              if(file!=null) {
                setState(() {
                  image = FileImage(File(file.path));
                });
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [
              Align(alignment: Alignment.topLeft,
                  child: Text("Hазва страви", textScaleFactor: 1.5,)
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value){title=value;},
              ),
            ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [
              Align(alignment: Alignment.topLeft,
                  child: Text("Опис страви", textScaleFactor: 1.5,)
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (value){description=value;},
              ),
            ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBarButton("Додати страву",onTapHandler: Submit),
          )
        ],
        ),
      )
    );
  }
  Submit(){
    if(ValidateInput()){
      SaveItem();
    }
  }
  bool ValidateInput(){
    if(title.isEmpty){
      //TODO:Alert "invalid title"
      return false;
    }
    else if(description.isEmpty){
      //TODO:Alert "invalid description"
      return false;
    }
    else if(image==AssetImage("assets/images/empty_plate.jpg")){
      //TODO:Alert "invalid image"
      return false;
    }
    return true;
  }
  void SaveItem(){
    //TODO: Implement SaveItem() which will save data to DB?
  }
}