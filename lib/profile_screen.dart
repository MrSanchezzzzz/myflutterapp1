
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? _selectedValue=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 8,top: 64),
              //alignment: Alignment.topLeft,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height*0.2,
              ),
              //Profile image and name
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                  ClipOval(
                    child: Image(
                      width: 65,
                      height: 65,
                      image: AssetImage("assets/images/Ellipse_117.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*0.65,
                          maxHeight: double.infinity,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Text("Марина Iвасюк",style: TextStyle(fontSize: 18)),
                                    Icon(Icons.create_outlined,size: 12,)
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                                child: InkWell(
                                    child: Text("+38 098 456 42 55"),
                                  onTap: (){},
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],),
              ),
            ),
            //Card type combobox
            Container(
              margin: EdgeInsets.symmetric(vertical: 32),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(16)
              ),
              height: 60,
              child: Center(
                child: DropdownButton<int>(
                  icon: Transform.rotate(
                    angle: math.pi/2,
                      child: Icon(Icons.arrow_forward_ios)
                  ),
                  isExpanded: true,
                  underline: Container(),
                  value: _selectedValue,
                  onChanged: (value){setState(() {
                    _selectedValue=value;
                  });},
                   items: GenerateDropDownMenuItems()

                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height*0.5
              ),
              child: ListView.separated(
                itemBuilder: (context,index){
                 return Container(
                   child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Image(
                                image: AssetImage(menuOptions[index][1]),
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 4),
                              child: Text(menuOptions[index][0]),
                            )
                          ],
                        ),
                      ),
                     onTap: SelectCallback(index,context),
                    ),
                  );
                },
                itemCount: menuOptions.length,
                separatorBuilder: (context,index)=>const Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
  ShowCallMenu(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        padding: EdgeInsets.only(top: 24,bottom: 18,left: 8,right: 8),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/2.5),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(
                color:Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(callOptions[index][0],style: TextStyle(fontSize: 18),),
                  Image(image: AssetImage(callOptions[index][1]),width: 32,height: 32,)
                ],
              ),
            );
          },
          separatorBuilder: (context,index){
            return Container(height: 16,);
          },
        ),
      );
    });
  }
  List<List<String>> callOptions=[
    ["Подзвонити","assets/images/phone_icon.png"],
    ["Viber","assets/images/viber_icon.png"],
    ["WhatsApp","assets/images/whatsapp_icon.png"]
  ];
  //String,string - title, path to image
  List<List<String>> menuOptions=[
    ["Iсторiя замовлень","assets/images/history.png"],
    ["Бронювання","assets/images/my_reserve.png"],
    ["Правила проекта","assets/images/faq.png"],
    ["Запросити друзiв","assets/images/share_with_friends.png"],
    ["Технiчна пiдтримка","assets/images/support.png"],
    ["Вийти","assets/images/logout.png"],
  ];
  Function() SelectCallback(int index,BuildContext context){
    switch(index){
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        return (){ShowCallMenu(context);};
        break;
      case 5:
        break;

    }
    return (){};
  }
  List<DropdownMenuItem<int>> GenerateDropDownMenuItems(){
    List<DropdownMenuItem<int>> widgets=[];
    List<String> images=["assets/images/Apple_Pay_Mark.png","assets/images/mastercard_mark.png"];
    List<String> labels=["Apple Pay","MasterCard **** **** **** ****"];
    for(int i=0;i<labels.length||i<images.length;i++){
      widgets.add(
        DropdownMenuItem(
            value: i,
            child: Container(
                child: Row(
                  children: [
                    Image(image: AssetImage(images[i]),width: 36,height: 23,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 4),
                      child: Text(labels[i],style: TextStyle(fontFamily: "SF Pro Display"),),
                    )
                  ],
                )
            )
        )
      );
    }
    return widgets;
  }
}