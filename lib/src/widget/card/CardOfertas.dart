import 'dart:ui';

import 'package:daloouser/data/model/PromocionesModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/material.dart';

class CardOfertas extends StatelessWidget{
  PromocionesModel model;

  CardOfertas({ this.model});
  @override
  Widget build(BuildContext context) {
    var radius15=BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15));
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey,blurRadius: 1)
          ]
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: radius15,
              image: DecorationImage(
                image: NetworkImage(BASE_URL_AMAZON_IMG+model.img),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: ClipRRect( //
              borderRadius:     radius15   ,// make sure we apply clip it properly
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
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.nameProduct,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Icon(Icons.star,color: primaryColor,size: 15,),
                        Text("${random(3,5)}",style: TextStyle(fontSize: 8,color: Colors.black,fontWeight: FontWeight.bold)),
                        Text("(${random(50,250)} reviews)",style: TextStyle(fontSize: 8,color: Colors.grey,))
                      ],
                    )
                  ],
                ),
                Text(model.nameService,textAlign: TextAlign.start,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("s/.",style: TextStyle(color: primaryColor,fontSize: 10),),
                        Text(model.price,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer,color: Colors.amber,size: 15,),
                        Text(model.timePrepare,textAlign:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}