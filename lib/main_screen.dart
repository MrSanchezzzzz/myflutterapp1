
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/main_top_container.dart';
import 'package:myflutterapp1/profile_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'Widgets/item_list_widget.dart';
import 'alert_dialog.dart';

class MainScreen extends StatefulWidget{
  MainScreen({Key? key}) : super(key: key);
  bool firstLaunch=true;
  @override
  MainScreenState createState() => MainScreenState();

}

class MainScreenState extends State<MainScreen> {

  void initState() {
    super.initState();
  }
  String _searchString="";

  int _selectedIndex=0;
  void OnInput(value){
    setState(() {
      _searchString=value;
    });
  }
  void ShowWelcomeMessage() async{
    String s=(await getTemporaryDirectory()).path;
    File f=File('$s/eucalyptTemp.txt');
    String username=(await f.readAsLines())[0];
    Timer(
        const Duration(milliseconds: 500),
            () => MyAlertDialog.showAlertDialog(context, "Вiтаю, $username, ви успiшно доданi в систему"));
  }
  @override
  Widget build(BuildContext context){
    if(widget.firstLaunch) {
      widget.firstLaunch=false;
      //ShowWelcomeMessage();
    }

    return Scaffold(
        body:
            Container(
              decoration: BoxDecoration(color:Color(0xffD1ECF8)),
              child: Column(children: [
                MainTopContainerWidget(onInputCallback: OnInput,),
                Expanded(child: selectScreen(_selectedIndex)),
                BottomNavigationBar(items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Головна"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_basket),
                      label: "Кошик"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                    label: "Профiль"

                  )
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xffa14e00),
                onTap: (index) {
                  if (index == 2) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                    return;
                  }
                    setState(() {
                      _selectedIndex = index;
                    });
                },
                )
              ],
              ),
            ),
        );
  }
  Widget selectScreen(int index){
    switch(index){
      case 0:
         return ItemsListWidget(searchPattern: _searchString);
      default:
        return Container();
    }
  }
}