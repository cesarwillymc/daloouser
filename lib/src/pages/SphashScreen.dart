import 'dart:async';

import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Locator.dart';


class SphashScreen extends StatefulWidget {
  @override
  _SphashScreenState createState() => new _SphashScreenState();
}

class _SphashScreenState extends State<SphashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=> locator<NavigationService>().navigateTo(MainScreenViewRoute));
    //
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => MainScreen())))
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset("",width: 200,height: 200,),
            ),
          ),
        ],
      ),
    );
  }
}
