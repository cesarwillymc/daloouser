import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Locator.dart';
import '../../../main.dart';

class AppBarMain extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Function searchpressed;
  final bool isVisibleLocation;
  final String titulo;

  AppBarMain({this.searchpressed, this.isVisibleLocation, this.titulo})
      : preferredSize = Size.fromHeight(60.0);

  @override
  _AppBarMainState createState() => _AppBarMainState();
}

class _AppBarMainState extends State<AppBarMain> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
        box: boxList[3],
        builder: (_,box){
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: widget.searchpressed,
                tooltip: 'Search',
              ),
              box.isEmpty?Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/profile.png",
                  width: 30,
                  height: 30,
                ),
              ):Container(
                margin: EdgeInsets.only(right: 8),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage((box.getAt(0) as UsuarioModel).uriImgPerfil),
                  ),
                ),
              ),
            ],
            title: widget.isVisibleLocation
                ? GestureDetector(
                    onTap: () {
                      if(comprobarLogin()){
                        _navigationService.navigateTo(ubicacionViewRoute);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                        ),
                        Flexible(
                            child: Container(
                                child: AutoSizeText(
                                  box.isEmpty?"Sin Usuario":(box.getAt(0) as UsuarioModel).address,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        )))
                      ],
                    ),
                  )
                : Center(
                    child: Text(widget.titulo,
                        style: TextStyle(color: Colors.black))),
          );
        });
  }
}
