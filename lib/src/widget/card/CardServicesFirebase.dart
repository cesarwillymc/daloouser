import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardServicesFirebase extends StatelessWidget{


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
          height: 130,
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
                        image: AssetImage("assets/comida.jpg"),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: Text("La mona cevicheriaaaaaaaaaaa",style: TextStyle(fontWeight: FontWeight.bold),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                          Card(
                            color: Colors.red,
                            child: Container(
                                width: MediaQuery.of(context).size.width*0.18,
                              padding: EdgeInsets.all(5),
                                child: Center(child: Text("EsperaAAAndo",style: TextStyle(color: Colors.white,fontSize: 10),overflow:TextOverflow.ellipsis ,))),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                alignment: Alignment.centerLeft,
                                child: Text("2 ordenes"),),
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: Row(
                                  children: [
                                    Text("5",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                    Icon(Icons.star,color: primaryColor,size: 18,),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          FloatingActionButton(onPressed: (){
                            callPhone("962601310");

                          },child: Icon(Icons.call,color: Colors.white,),backgroundColor: primaryColor,
                          )

                        ],
                      )
                    ],
                  )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}