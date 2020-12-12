import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCategorias extends StatelessWidget{
  final bool selected;
  final CategoryModel model;
  CardCategorias({ this.selected=true,this.model});

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child:  Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.all(3),
        height: 45,
        decoration: BoxDecoration(
            color: selected?primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.grey,blurRadius: 1)
            ]
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                margin: EdgeInsets.only(right: 10),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: selected?primaryColor:Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: model.id!="Todo"?NetworkImage(BASE_URL_AMAZON_IMG+model.img):AssetImage("assets/expand.png"),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Text(model.id,style: TextStyle(color: selected?Colors.white:Colors.black, fontWeight: FontWeight.bold,fontSize: 17),)
            ],

        ),
      ),
    );
  }

}