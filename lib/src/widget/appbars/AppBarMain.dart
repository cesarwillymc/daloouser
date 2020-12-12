import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarMain extends AppBar {
  final Function searchpressed;
  final bool isVisibleLocation;
  final  String titulo;

  AppBarMain({this.searchpressed, this.isVisibleLocation, this.titulo}):super(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: searchpressed,
        tooltip: 'Search',
      ),
      Image.asset(
        "assets/profile.png",
        width: 30,
        height: 30,
      )
    ],
    title: isVisibleLocation
        ? GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: primaryColor,
          ),
          Flexible(
              child: Container(
                  child: Text(
                    "Av Selva Alegre 534aqaaaaaaaaaaaa",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  )))
        ],
      ),
    )
        : Center(
        child: Text(titulo, style: TextStyle(color: Colors.black))),
  );


}