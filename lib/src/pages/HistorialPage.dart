import 'dart:ui';

import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardIconItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  var indexItem=0;
  @override
  Widget build(BuildContext context) {
    var texto =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.76,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("assets/comida.jpg"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: ClipRRect(
                      //,// make sure we apply clip it properly
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.blueGrey.withOpacity(0.1),
                          child: Image.asset("assets/comida.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ceviche de Pescado",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "s/.",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("20",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                Text("${random(3, 5)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                Text("5",
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontSize: 15, color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardIconItem(onTap: (){
                            setState(() {
                              if(_increment!=1){
                                _increment-=1;
                              }
                            });
                          },icon:Icons.remove,isBlue:false),
                          Text(
                            "$_increment",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          CardIconItem(onTap: (){
                            setState(() {
                              _increment+=1;
                            });
                          },icon:Icons.add,isBlue:true),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      texto,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,childAspectRatio: 8/2),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              indexItem=index;
                            });
                          },
                          child: TipePriceCardInactive("data.name", indexItem==index?true:false),
                        )),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              _settingModalBottonSheep(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 50,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.shopping_cart,color: Colors.white, size: 35,),
                  SizedBox(width: 20,),
                  Text("AÑADIR AL CARRITO", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  int _increment = 1;


  void _settingModalBottonSheep(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        backgroundColor: Colors.black,
        context: context,
        builder: (BuildContext bc) {
          return GestureDetector(
            onTap: () {
              //  Navigator.of(context).pushReplacement(MaterialPageRoute(
              //                            builder: (BuildContext context) => OrderPage()));
              // _navigationService.navigateTo(MainScreenViewRoute,arguments:OrderPage());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: Text(
                  "V E R CA R R I T O",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
  }
}
