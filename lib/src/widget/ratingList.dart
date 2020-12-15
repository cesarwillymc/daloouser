import 'package:flutter/material.dart';

class ratingList extends StatelessWidget {
  int start;
  int count;
  bool isLine;
  List<bool> listaBool = List<bool>();
  ratingList(this.start,this.count,{this.isLine=false});
  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 5; i++) {
      if ((5 - start) >= i) {
        listaBool.add(true);
      } else {
        listaBool.add(false);
      }
    }
    return Column(
      children: [
        Visibility(
          visible: !isLine,
          child: Text("$count",style: TextStyle(color: Colors.black),),
        ),
        isLine?Row(
            children: listaBool.map(_buildList).toList()
        ):Column(
            children: listaBool.map(_buildList).toList()
        )
      ]
      ,
    );
  }

  Widget _buildList(bool valor) {
    return Icon(valor ? Icons.star_border : Icons.star, color: Colors.blue,size: 14,);
  }
}