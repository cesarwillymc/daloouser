import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCardItem extends StatelessWidget{
  final ServiceItem model;

  SearchCardItem({ this.model}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:[
          BoxShadow(
            color: Colors.blueGrey,
            blurRadius: 3,
            offset: Offset(0,2)
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          height: 120,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
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
                      Text(model.name,maxLines: 2,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(model.address,style: TextStyle(color: Colors.grey,fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: model.isProduct?false:true,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star,color: primaryColor,),
                                Text(model.ratingNumber,textAlign: TextAlign.center,style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(model.isProduct?model.namedRest:model.isOpen?"ABIERTO":"CERRADO",maxLines:1,textAlign: TextAlign.end,overflow: TextOverflow.ellipsis,),
                            ),
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