import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:myflutterapp1/Widgets/item_list_widget.dart';
import 'package:myflutterapp1/start_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'profile_screen.dart';
import 'auth_screen.dart';
import 'main_screen.dart';

class Food{
  final String name;
  String? description;
  String? weight;
  double? price;
  Food({required this.name,this.description,this.weight,this.price});
}
List<Food> foodsInCart=[];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale:Locale("uk",'UA') ,
      supportedLocales: [
        //Locale("en",'US'),
        Locale("uk",'UA'),
      ],
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "SEOULHANGANG CBL",
      ),
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
          //TODO: change to StartScreen();
            context, MaterialPageRoute(builder: (context) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage("assets/images/logo.png"),
            width: 100,
            height: 100,
          ),
          Text("Eucalypt", textScaleFactor: 2)
        ],
      ),
    );
  }
}




