import 'package:flutter/material.dart';
import 'Widgets/bottom_app_bar_button.dart';
class ItemDetailsScreen extends StatelessWidget {
  final String _title;
  final String _text;
  final ImageProvider _image;

  ItemDetailsScreen(this._title, this._text, this._image);
  var _context;
  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
      appBar: AppBar(title: Text(this._title)),
      body: Column(
        children: [
              Expanded(child:
              ListView(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Image(
                      image: this._image,
                      width: 300,
                      height: 300,
                    ),
                  )
                ]),
                Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: Align(
                      child: Text(
                        _text,
                        textScaleFactor: 1.5,
                      ),
                      alignment: Alignment.topLeft,
                    )
                ),
              ],)
              ),
          BottomAppBar(
            child: Column(
                children: [
                  BottomAppBarButton("Додати в вибрані",onTapHandler: AddToFavourites),
                  BottomAppBarButton("Зрівняти"), //TODO: Implement method to compare items and bind it to onTapHandler
                ])
          )
        ],
      ),
    );
  }
  void AddToFavourites(){
    AlertDialog dialog=AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      content: Container(
        child:SizedBox(
          height: 150,
          width: 300,
        child: Column(children: [
          Expanded(child:Align(
            alignment: Alignment.center,
            child: Text("Успішно додано в обрані",style: TextStyle(
                fontSize: 36,
              ),
            ),
          ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBarButton("OK",onTapHandler:(){ Navigator.pop(_context);},
          )
          ),
        ],),
      ),
      )
    );
  showDialog(context: _context,builder:(BuildContext context)=>dialog);
  }
}