import 'package:flutter/material.dart';
import 'package:myflutterapp1/alert_dialog.dart';
import 'Widgets/bottom_app_bar_button.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String _title;
  final String _text;
  final ImageProvider _image;
  final int _weight;
  final int _price;
  ItemDetailsScreen(
      this._title, this._text, this._image, this._weight, this._price);
  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height * 0.55;
    double bottomHeight = MediaQuery.of(context).size.height * 0.60;
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Image(
              image: this._image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            width: double.infinity,
            height: topHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: bottomHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              this._title,
                              style: TextStyle(
                                  fontSize: 24, color: Color(0xff5B5B5B)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              this._text,
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xff5B5B5B)),
                            ),
                          ),
                        ]),
                  ),
                  height: bottomHeight*0.6,
                  padding: EdgeInsets.only(top:8,left:8,right: 8),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Image(
                              image: AssetImage(
                                  "assets/images/item_details_line.png"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Вага: " + this._weight.toString() + "г",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff5B5B5B)),
                                  ),
                                  Text(
                                    "Цiна:" + this._price.toString() + "грн",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff5B5B5B)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            bottom: 20, top: 0, left: 10, right: 10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff4D662D),
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        width: double.infinity,
                        height: 60,
                        child: TextButton(
                          onPressed: () {
                            MyAlertDialog.showAlertDialog(
                                context, "Успiшно додано в кошик");
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Додати в кошик",
                                style: TextStyle(
                                    color: Color(0xffD1D5DB), fontSize: 17),
                              )),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff4D662D),
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        width: double.infinity,
                        height: 60,
                        child: TextButton(
                          onPressed: () {},
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Порiвняти",
                                style: TextStyle(
                                    color: Color(0xffD1D5DB), fontSize: 17),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
/*
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.6,maxHeight: MediaQuery.of(context).size.height*0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._title,style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xff5B5B5B)),),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._text,style: TextStyle(fontSize: 17,color:Color(0xff5B5B5B)),),
                            )
                          ],
                        ),
                      ),
                    ),

                    ),
                  ],
                ),
              ),
            ),



            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 35),

                child: CloseButton(
                  onPressed: (){Navigator.pop(context);},
                ),
              ),
            ),
* */
