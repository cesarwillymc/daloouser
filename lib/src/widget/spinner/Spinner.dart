import 'package:daloouser/data/model/CategoriasModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget{
  Function llave;
  List<CategoriasModel> items;
  Spinner(this.llave,this.items,this.valueItem);
  CategoriasModel valueItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: DropdownButton<CategoriasModel>(
        value: valueItem,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: primaryColor),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: llave,
        items: items
            .map<DropdownMenuItem<CategoriasModel>>((CategoriasModel value) {
          return DropdownMenuItem<CategoriasModel>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      ),
    );
  }

}