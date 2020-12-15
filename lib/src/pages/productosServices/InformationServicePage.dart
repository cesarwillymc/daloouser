import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationServicePage extends StatelessWidget{
  ServiceModel model;
  InformationServicePage({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("Informacíon",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
          Text("textoooooo",style: TextStyle(color: Colors.black),),
          Text("Direccíon",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
        ],
      ),
    );
  }
  
}