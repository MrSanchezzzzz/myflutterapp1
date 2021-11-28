
import 'package:flutter/material.dart';
import 'package:myflutterapp1/Widgets/main_top_container.dart';
import 'package:myflutterapp1/item_create_screen.dart';
import 'Widgets/item_list_widget.dart';
import '../item_create_screen.dart';
import 'alert_dialog.dart';
class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();

}

class MainScreenState extends State<MainScreen> {
  void initState() {
    super.initState();
    //WidgetsBinding.instance!.addPostFrameCallback((_) => MyAlertDialog.showAlertDialog(context, "Вiтаю, %username%, ви успiшно доданi в систему"));
  }
  String _searchString="";

  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Container(
              decoration: BoxDecoration(color:Color(0xffD1ECF8)),
              child: Column(children: [
                MainTopContainerWidget(),
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

                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xffa14e00),
                onTap: (index){setState(() {
                  _selectedIndex=index;
                });},
                )
              ],
              ),
            ),
        );
  }
  Widget selectScreen(int index){
    List<Widget> screens=[
      ItemsListWidget(searchPattern: _searchString),

    ];
    if(index<0||index>screens.length-1) {
      return Container();
    }

    return screens.elementAt(index);
  }
}