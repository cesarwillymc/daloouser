import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardRiderServiceFirebase extends StatelessWidget{
  DocumentSnapshot doc;
  CardRiderServiceFirebase(this.doc);

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
          height: 100,
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
                        image: NetworkImage(BASE_URL_AMAZON_IMG+ doc["imgRider"].toString()),
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
                      Text(doc["nameRider"].toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("4.5",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                              Icon(Icons.star,color: primaryColor,size: 18,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton(onPressed: () async {
                                await launchWhatsApp("+51${doc["riderPhone"]}", "Hola  tengo un pedido con usted, deseo comunicarle lo siguiente: ");

                              },child: Icon(Icons.message,color: Colors.white,),backgroundColor: primaryColor,),
                              FloatingActionButton(onPressed: (){
                                callPhone(doc["riderPhone"].toString());

                              },child: Icon(Icons.call,color: Colors.white,),backgroundColor: primaryColor,)
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ),
              Container(
                width: 10,
                height: 10,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }

}