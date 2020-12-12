import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Locator.dart';
import 'CardCategorias.dart';
import 'CardOfertas.dart';
import 'CardProductosItem.dart';

class CardProductosMain extends StatelessWidget{
  ListaProductosCategoria model;

  CardProductosMain({ this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(model.service.name,textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Text("Ver mas",textAlign: TextAlign.end,style: TextStyle(color: primaryColor,fontSize: 14,fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Container(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: model.items.length,
                  itemBuilder:(context, index) {
                    return GestureDetector(
                      onTap: (){
                        locator<NavigationService>().navigateTo(PreviewProductViewRoute,arguments: model.items[index].id);
                      },
                      child: CardProductosItem(model.items[index]),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

}