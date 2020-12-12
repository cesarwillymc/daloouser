import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardIconItem extends StatelessWidget{
  Function onTap;
  IconData icon;
  bool isBlue;
  CardIconItem({@required this.onTap,@required this.icon,@required this.isBlue});
  @override
  Widget build(BuildContext context) {
    var tamanioButton = 25.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: tamanioButton,
        height: tamanioButton,
        decoration: BoxDecoration(
            color: isBlue?primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(tamanioButton / 4),
            boxShadow: [BoxShadow(color: primaryColor)]),
        child: Center(
          child: Icon(
            icon,
            color: isBlue?Colors.white:primaryColor,
            size: tamanioButton - (tamanioButton * 0.26),
          ),
        ),
      ),
    );
  }

}