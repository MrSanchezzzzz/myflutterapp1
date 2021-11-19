
import 'package:flutter/material.dart';
import '../../item_details_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class _Item {
  final String title;
  final ImageProvider image;
  final String description;
  _Item(this.title, this.description ,this.image);
}

class ItemsListWidget extends StatefulWidget {
  ItemsListWidget({Key? key,String searchPattern=""}) : super(key: key){
        this.searchPattern=searchPattern;
  }
  String searchPattern="";
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
        itemBuilder: (BuildContext context, int index){
            return SizedBox(
                child: InkWell(
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image(image: itemsToDisplay[index].image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                            Expanded(child:
                            Text(
                              itemsToDisplay[index].title,
                              style: TextStyle(fontSize: 24),
                              overflow: TextOverflow.ellipsis,
                              ),
                            )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetailsScreen(itemsToDisplay[index].title, itemsToDisplay[index].description, itemsToDisplay[index].image)));
                      },
                    )
            );

        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
  var lastLoadedItemIndex=0;
  //Todo: implement getItems method
  ///count(int) - how many NEW items should method add to list
  ///searchPattern(string) - Checks if item.title contains this string
  getItems({int count=5}) async {
    getFile();
    List<_Item> items = [
      _Item("Русские щи",
          "Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года.Суп из капусты. Придуман в Росии. Мы изменили пенсионный возраст чтобы он был в списке блюд еще 4 года",
          AssetImage("assets/images/item1_image.jpg")),
      _Item("Украинский борщ",
          "Вкусный, сытный, наваристый, красный,как нос алкаша, борщ",
          AssetImage("assets/images/item2_image.jpg")),
      _Item("Итальянский томатный суп",
          "Непонятная бурда. Вроде из помидоров. Не пробовал",
          AssetImage("assets/images/item3_image.jpg"))
    ];
    itemsToDisplay.clear();
    for (_Item i in items) {
      if (!i.title.contains(RegExp(widget.searchPattern, caseSensitive: false))) {
        continue;
      }
      itemsToDisplay.add(i);
    }
  }
  Future<File> getFile() async{
    final path=(await getApplicationDocumentsDirectory()).path;
    final file=File("$path/items.txt");
    if(!await file.exists()) {
      file.create(recursive: true);
    }
    return file;
  }
}