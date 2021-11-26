
import 'package:flutter/material.dart';
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
  String _searchString="";

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => MyAlertDialog.showAlertDialog(context, "Вiтаю, %username%, ви успiшно доданi в систему"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Eucalypt"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      ItemCreateScreen()));
                  },
                  child: const Icon(Icons.add),
                ),
            ),
          ],
        ),
        body:
            Column(children: [
              Container(
                color:Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter text to search',
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                          _searchString=value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(child: ItemsListWidget(searchPattern: _searchString)),
            ],
            ),
        );
  }
}