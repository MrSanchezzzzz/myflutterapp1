import 'package:flutter/material.dart';
import 'package:myflutterapp1/alert_dialog.dart';
import 'Widgets/bottom_app_bar_button.dart';
import 'main.dart';

class ItemDetailsScreen extends StatelessWidget {
  
  ImageProvider? image;
  late Food f;
  ItemDetailsScreen(Food food, {this.image}){
    f=food;
  }
  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height * 0.50;
    double bottomHeight = MediaQuery.of(context).size.height * 0.65;
    return Scaffold(
        body: Stack(
        children: [
          Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Image(
              image: this.image??AssetImage("assets/images/coala_item.jpg"),
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
            child:
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top:15,bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Title and text
                  Column(
                    children: [
                      Padding(
                        child: Align(
                          child: Text(f.name,style: TextStyle(fontSize: 24),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        padding: EdgeInsets.only(bottom: 9),
                      ),
                      SingleChildScrollView(
                          child: Text(f.description??"",style: TextStyle(fontSize: 17),)
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),

                  //Weight,price and buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:10,bottom: 15),
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
                                    "Вага: " + f.weight.toString()+ "г",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff5B5B5B)),
                                  ),
                                  Text(
                                    "Цiна:" + f.price!.round().toString() + "грн",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff5B5B5B)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){
                                foodsInCart.add(f);
                                MyAlertDialog.showAlertDialog(context, "Додано в кошик");
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4D662D)),
                                foregroundColor:MaterialStateProperty.all<Color>(Color(0xffD1D5DB)),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 18)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                )
                              ),
                              child: Text("Додати в кошик",style: TextStyle(fontSize: 17),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4D662D)),
                                foregroundColor:MaterialStateProperty.all<Color>(Color(0xffD1D5DB)),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 18)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),
                          ),
                                child: Text("Порiвняти",style: TextStyle(fontSize: 17),),
                        )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    )
    );
  }
}
/*

 */

