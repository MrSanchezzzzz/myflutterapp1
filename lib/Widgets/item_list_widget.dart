import 'package:flutter/material.dart';
import '../../item_details_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:indexed/indexed.dart';
class _Item {
  final String title;
  final ImageProvider image;
  final String description;
  final int weight;
  final int price;
  _Item(this.title, this.description, this.image,this.weight,this.price);
}

class ItemsListWidget extends StatefulWidget {
  ItemsListWidget({Key? key, String searchPattern = ""}) : super(key: key) {
    this.searchPattern = searchPattern;
  }
  String searchPattern = "";
  @override
  ItemListWidgetState createState() => ItemListWidgetState();
}

class ItemListWidgetState extends State<ItemsListWidget> {
  List<_Item> itemsToDisplay = [];

  @override
  Widget build(BuildContext context) {
    getItems(); //TODO: Should i make getItems() async?
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      itemCount: itemsToDisplay.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
              Container(
                margin: EdgeInsets.only(left: 45),
                padding: EdgeInsets.only(left: 10,right:10,top: 8,bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xff4D662D),
                    borderRadius: BorderRadius.circular(10)),
                constraints: BoxConstraints(
                    minHeight: 68, maxHeight: double.infinity),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 55,right: 8,top: 8,bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      itemsToDisplay[index].title,
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xffD1D5DB),
                          fontFamily: "Viaoda Libre"
                      ),
                    ),
                  ),
                ),
              ),
                ClipOval(
                  child: Image(
                    image: itemsToDisplay[index].image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemDetailsScreen(
                          itemsToDisplay[index].title,
                          itemsToDisplay[index].description,
                          itemsToDisplay[index].image,
                          itemsToDisplay[index].weight,
                          itemsToDisplay[index].price
                      )
                  )
              );
            },
          ),
        )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 20,color: Colors.transparent,),
    );
  }

  var lastLoadedItemIndex = 0;
  //Todo: implement getItems method
  ///count(int) - how many NEW items should method add to list
  getItems({int count = 5}) async {
    List<_Item> items = [
      _Item(
          "Русские щи",
          "Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года",
          AssetImage("assets/images/item1_image.jpg"),
          125,999),
      _Item(
          "Украинский борщ",
          "Вкусный, сытный, наваристый, красный,как нос алкаша, борщ",
          AssetImage("assets/images/item2_image.jpg"),
          125,55),
      _Item(
          "Итальянский томатный суп с ооочччееенннььь дддлииинннннныыыммм нннааазззввваааннниииеееммм",
          "Непонятная бурда. Вроде из помидоров. Не пробовал",
          AssetImage("assets/images/item3_image.jpg"),
          166,100),
      _Item(
        "Лакса з курчам",
        "Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.Курча, карамелiзований баклажан та скляна локшина.",
        AssetImage("assets/images/image_1.png"),
          100,
          250
      )
    ];
    itemsToDisplay.clear();
    for (_Item i in items) {
      if (!i.title
          .contains(RegExp(widget.searchPattern, caseSensitive: false))) {
        continue;
      }
      itemsToDisplay.add(i);
    }
  }
}
