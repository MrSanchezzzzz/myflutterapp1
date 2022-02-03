import 'dart:convert';

import 'package:flutter/material.dart';
import '../../item_details_screen.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
class _Item {
 final int id;
 final List<dynamic> food_options;
 final String name;
 _Item({
   required this.id,
   required this.food_options,
   required this.name
 });
 factory _Item.fromJson(Map<String, dynamic> json){
   return _Item(
     id: json["id"],
     food_options: json["foods"]??[],
     name: json["name"]
   );
 }
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
  @override void initState(){
    getFoods();
    super.initState();
  }

  List<Food> foods = [];
  List<Food> foodsToDisplay=[];
  void FilterFoods() {
    foodsToDisplay.clear();
    for (Food f in foods) {
      if (f.name.contains(widget.searchPattern)) {
        foodsToDisplay.add(f);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    FilterFoods();
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      itemCount: foodsToDisplay.length,
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
                      foodsToDisplay[index].name,
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
                    image: AssetImage("assets/images/coala_item.jpg"),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            onTap: () {
             //TODO: Move to item details screen
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetailsScreen(foodsToDisplay[index])
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
  ///count(int) - how many NEW items should method add to list
  getFoods({int count = 5}) async {
    List<_Item> items = [];
    items = await fetchList();

    foods.clear();
    for (_Item i in items) {
      for (Map<String, dynamic> food in i.food_options){
        Food f=Food(
            name: food["name"],
            description: food["description"],
          weight:food["weight"].toString(),
          price: double.parse(food["price"].toString())
        );
        if(f.name.contains(widget.searchPattern)){
          foods.add(f);
        }
      }
    }
    print("Fetched "+foods.length.toString()+" items");
    setState(() {});
  }
  Future<List<_Item>> fetchList() async{
    final responce=await http.get(Uri.parse('http://dev.cherest.com.ua/api/v3/user/restaurant/83/menu'));
    if(responce.statusCode==200){
      List jsonResponce=jsonDecode(responce.body);
      return jsonResponce.map((item) => new _Item.fromJson(item)).toList();
    }
    throw Exception("Fetch error");
  }
}
