import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardProductosItem extends StatelessWidget{
  ProductoData model;
  CardProductosItem(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:[
            BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 2,
                offset: Offset(0,1)
            )
          ]
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(BASE_URL_AMAZON_IMG+model.img),
                        fit:BoxFit.cover
                    )

                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name,maxLines: 1,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16,),overflow: TextOverflow.ellipsis,),
                      Text(model.description,style: TextStyle(color: Colors.black,fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("s/.",style: TextStyle(color: primaryColor,fontSize: 10),),
                              Text(model.priceGeneral.toString(),style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold))
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}