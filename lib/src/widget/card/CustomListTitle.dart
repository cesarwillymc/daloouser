import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget{
  final IconData icon;
  final String title;

  CustomListTitle({ this.icon, this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child:  Row(
        children: [
          Icon(icon,color: Colors.blue,),
          SizedBox(width: 15,),
          Text(title,style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }

}