
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myflutterapp1/Widgets/auth/login_input_widget.dart';
import 'package:myflutterapp1/Widgets/auth/phone_input_widget.dart';
import 'package:myflutterapp1/location_selection_screen.dart';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myflutterapp1/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'button.dart';
import 'package:intl/intl.dart';
//TODO: implement callback for location selection
class OrderScreen extends StatefulWidget{
  @override
  State<OrderScreen> createState() => _OrderScreenState();

}

class _OrderScreenState extends State<OrderScreen> {
  int? _selectedValue = 2;
  double totalPrice = 0;

  double deliveryPrice = 40;
  String deliveryClientPhoneNumber="";
  //Date and time when order should be delivered(for display purposes)
  String deliveryEstimateTime = "Як можна швидше";
  List<FoodInfoContainer> foodInfos = [];
  List<int> prices = [];
  LatLng deliveryLocation=LatLng(0, 0);
  @override
  void initState() {
    super.initState();
    foodInfos = GetFoods();
  }

  void CalculatePrice() {
    List<int> counts = GetFoodsCounts();
    totalPrice = 0;
    if (counts.length < 1 || foodsInCart.length < 1) {
      setState(() {});
      return;
    }
    for (int i = 0; i < foodsInCart.length; i++) {
      print(foodsInCart[i].price);
      if (foodsInCart[i].price == null) {
        print("Price is null");
        continue;
      }
      totalPrice += foodsInCart[i].price! * counts[i];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CalculatePrice();
    return Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffE5E5E5),
        body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 18, bottom: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius
                                .circular(12), bottomRight: Radius.circular(
                                12)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ваше замовлення", style: TextStyle(
                                  fontSize: 24, fontFamily: "SF Pro Display"),),
                              CloseButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                            padding: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                                border: Border.all()
                                            ),
                                            child: DropdownButton<int>(
                                                icon: Transform.rotate(
                                                    angle: math.pi / 2,
                                                    child: Icon(
                                                        Icons.arrow_forward_ios)
                                                ),
                                                isExpanded: true,
                                                underline: Container(),
                                                value: _selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue = value;
                                                  });
                                                },
                                                items: GenerateDropDownMenuItems()

                                            )
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            child: Label(text: "Місце доставки",
                                              widget: Icon(Icons
                                                  .add_location_alt_outlined),
                                              onTap: () {
                                                ShowLocationSelectionScreen(
                                                    context);
                                              },
                                            ),

                                          ),
                                          InkWell(
                                              child: Label(
                                                text: deliveryEstimateTime,
                                                widget: Icon(Icons.access_time),
                                              ),
                                            onTap: (){
                                              ShowTimeSelectionDialog(context);
                                            },
                                          ),
                                          InkWell(
                                              child: Label(
                                                text: "Контактний номер",
                                                widget: Icon(
                                                    Icons.edit_outlined),
                                              ),
                                                  onTap:(){ShowPhoneNumberInputDialog();}
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: foodInfos,
                                      ),
                                      //Space between foods and other labels
                                      Container(height: 12,),

                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Label(text: "Доставка",
                                widget: Text(deliveryPrice.toString() + "₴",
                                  style: TextStyle(
                                      fontFamily: "SF Pro Display"),),),
                              Label(text: "Всього",
                                widget: Text(totalPrice.toString() + "₴",
                                  style: TextStyle(
                                      fontFamily: "SF Pro Display"),),),
                              Container(height: 8,),
                              Label(text: "Ваш коментар",),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 16),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 4,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Коментар"
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13),
                                child: Button(text: "Замовити", onTap: () {},),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
  OnMapSelectedCallback(LatLng location){
    print("User selected location:\n"+location.toString());
    deliveryLocation=location;

  }
  List<DropdownMenuItem<int>> GenerateDropDownMenuItems() {
    List<DropdownMenuItem<int>> widgets = [];
    List<String> images = [
      "assets/images/Apple_Pay_Mark.png",
      "assets/images/mastercard_mark.png",
      ""
    ];
    List<String> labels = [
      "Apple Pay",
      "MasterCard **** **** **** ****",
      "Готівка"
    ];
    for (int i = 0; i < labels.length || i < images.length; i++) {
      widgets.add(
          DropdownMenuItem(
              value: i,
              child: Container(
                child: Row(
                  children: [
                    images[i] == "" ? Container() : Image(
                      image: AssetImage(images[i]), width: 36, height: 23,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: Text(labels[i],
                        style: TextStyle(fontFamily: "SF Pro Display"),),
                    ),
                  ],
                ),

              )
          )
      );
    }
    return widgets;
  }
  String DayOfWeek(int number){
    if(number<1||number>7)
      throw ArgumentError("Only 1-7 allowed when choosing day of week");

    switch(number){
      case 1:
        return "Понеділок";
        case 2:
        return "Вівторок";
        case 3:
        return "Середа";
        case 4:
        return "Четвер";
        case 5:
        return "П'ятниця";
        case 6:
        return "Субота";
    }
    return "Неділя";
  }
  List<FoodInfoContainer> GetFoods() {
    List<FoodInfoContainer> widgets = [];
    for (Food f in foodsInCart) {
      widgets.add(
          FoodInfoContainer(food: f, onChangedCallback: CalculatePrice,));
      prices.add((f.price ?? 0).round());
    }
    return widgets;
  }
  List<int> GetFoodsCounts() {
    List<int> c = [];
    for (FoodInfoContainer f in foodInfos) {
      if (f.Count != 0) {
        c.add(f.Count);
      }
    }
    return c;
  }
  void ShowLocationSelectionScreen(BuildContext context) async{
    Permission.location.request();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSelectionScreen(onLocationSelectedCallback: OnMapSelectedCallback,)));
  }
  void ShowTimeSelectionDialog(BuildContext context){
    DateTime now=DateTime.now();
    DateTime selectedDate=DateTime.now();
    showModalBottomSheet(context:
    context,
        builder: (context)
        {
          return Container(
            //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.75),
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      color: Color(0xff4D662D),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text("Готово",style: TextStyle(color: Color(0xffD1D5DB),fontSize: 17),),
                        ),
                      ),
                    ),
                    onTap: (){
                      deliveryEstimateTime=DayOfWeek(selectedDate.weekday)+", "+DateFormat("d HH:mm").format(selectedDate);
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (date){
                        selectedDate=date;
                      },
                      minimumDate: DateTime(now.year,now.month,now.day,now.hour,now.minute),
                      //maximumDate: ,
                      use24hFormat: true,
                    ),
                  ),
                ],
              ),
          );
        });
  }
  void ShowPhoneNumberInputDialog(){
    TextEditingController _controller=TextEditingController();
    _controller.text=deliveryClientPhoneNumber;
    showModalBottomSheet(context: context,
        builder: (context){
          return Container(

            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+8,top:44,left: 30,right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Змінити контактний номер",style: TextStyle(fontSize: 24),),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Viaoda Libre",
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        //prefixIcon: Padding(
                          //  padding: EdgeInsets.only(top: 15),
                            //child: Icon(Icons.language, color: Colors.black,)
                        //),
                        hintText:"+380 97 661 82 83"
                    ),
                    controller: _controller,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: '+38# ## ### ## ##', filter: { "#": RegExp(r'[0-9]') })
                    ],
                    onChanged: (value){
                      deliveryClientPhoneNumber=value;
                    },
                    onTap: (){
                      if(_controller.text==""){
                        _controller.text+="+38";
                        setState(() {});
                      }
                    },

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Button(text: "Готово", onTap: (){
                      Navigator.pop(context);
                    }),
                  )
                ],
              ),
            ),
          );

        },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))),
      isScrollControlled: true,
    );
  }
}
class Label extends StatelessWidget{
  String text;
  Widget? widget;
  Function()? onTap;
  Label({required this.text, this.widget,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.text,style: TextStyle(fontSize: 16,fontFamily: "SF Pro Display"),),
            widget??Container()
          ],
        ),
        onTap: this.onTap,
      ),
    );
  }
}
class FoodInfoContainer extends StatefulWidget{
  Food food;
  Function() onChangedCallback;

  FoodInfoContainer({required this.food,required this.onChangedCallback});
  @override
  State<FoodInfoContainer> createState() => _FoodInfoContainerState();

  int Count=1;

}

class _FoodInfoContainerState extends State<FoodInfoContainer> {
  @override
  Widget build(BuildContext context) {
    if(widget.Count<1){
      return Container();
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/9),
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipOval(
                  child: Image(image: AssetImage("assets/images/coala_item.jpg"),width: 70,height: 70,fit: BoxFit.fill,),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(alignment: Alignment.centerLeft,child: Text(widget.food.name,style: TextStyle(fontSize: 16,fontFamily: "SF Pro Display",fontWeight: FontWeight.bold),)),
                    Spacer(),
                    Align(alignment: Alignment.centerLeft,child: Text((widget.food.weight??"")+"г",style: TextStyle(fontSize: 14,fontFamily: "SF Pro Display"),)),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text((widget.food.price??0).round().toString()+"₴",
                              style: TextStyle(fontSize: 16,fontFamily: "SF Pro Display"),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  child: Text("-"),
                                  onTap: (){setState(() {
                                    widget.Count--;
                                    widget.onChangedCallback();
                                  });},
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(widget.Count.toString()),
                                ),
                                InkWell(
                                  child: Text("+"),
                                  onTap: (){setState(() {
                                    widget.Count++;
                                    widget.onChangedCallback();
                                  });},
                                ),
                              ],
                            )

                          ],
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}