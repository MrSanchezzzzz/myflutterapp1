import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoadingScreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainMenu())));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/coala_logo.jpg"),
            width: 100,
            height: 100,
          ),
          Text("Koala", textScaleFactor: 2)
        ],
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World!"),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("First"),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("Second"),
                        value: 2,
                      )
                    ])
          ],
        ),
        body: ItemsList());
  }
}

class ItemMenu extends StatelessWidget {
  final String _title;
  final String _text;
  final ImageProvider _image;

  ItemMenu(this._title, this._text, this._image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title)),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Image(
                image: this._image,
                width: 300,
                height: 300,
              ),
            )
          ]),
          Expanded(
              child: Align(
            child: Text(
              _text,
              textScaleFactor: 1.5,
            ),
            alignment: Alignment.topLeft,
          )),
          BottomAppBar(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.all(2.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  width: double.infinity,
                  child: TextButton(onPressed: () {}, child: Text("Action1"))),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.all(2.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  width: double.infinity,
                  child: TextButton(onPressed: () {}, child: Text("Action2")))
            ]),
          ))
        ],
      ),
    );
  }
}

class _Item {
  final String title;
  final ImageProvider image;

  _Item(this.title, this.image);
}

class ItemsList extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemsList> {
  List<Widget> getItems(BuildContext context, {String searchPattern = ""}) {
    List<_Item> items = [
      _Item("text1", AssetImage("assets/images/coala_item.jpg")),
      _Item("text2", AssetImage("assets/images/coala_item.jpg")),
      _Item("text3", AssetImage("assets/images/coala_item.jpg"))
    ];

    List<SizedBox> boxes = [];

    for (_Item i in items) {
      if (!i.title.contains(new RegExp(searchPattern, caseSensitive: false))) {
        continue;
      }
      boxes.add(SizedBox(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.horizontal(),
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: i.image,
                        width: 125,
                        height: 125,
                      ),
                      Text(
                        i.title,
                        textScaleFactor: 2,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemMenu(i.title, "BLAH BLAH BLAH", i.image)));
                },
              ))));
    }
    return boxes;
  }

  String searchPattern = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter text to search',
                labelText: 'Search',
                prefixIcon: Icon(Icons.search)),
            onChanged: (value) {
              setState(() {
                searchPattern = value;
              });
            },
          ),
        ),
        Expanded(
            child: ListView(
          children: getItems(context, searchPattern: this.searchPattern),
        ))
      ],
    );
  }
}
