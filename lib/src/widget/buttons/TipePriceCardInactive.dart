import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipePriceCardInactive extends StatelessWidget {
  bool active;
  String palabra;

  TipePriceCardInactive(this.palabra, this.active);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: active ? primaryColor : Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            palabra,
            textScaleFactor: 1.2,
            style: TextStyle(color: active ? Colors.white:primaryColor,fontSize: 18),
          ),
        ),
      ),
    );
  }
}
