import 'dart:convert';

import 'package:daloouser/data/model/CarritoModel.dart';

class SendCarrito{


   String comentario;
   String tipePay;
   List<CarritoModel> listadepedidos;
   String url;

  SendCarrito(this.comentario, this.tipePay, this.listadepedidos, this.url);


  Map<String, dynamic> toJson() {
    final  Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listadepedidos != null) {
      var dato=this.listadepedidos.map((v) => v.toJson()).toList();
      data['listadepedidos'] = dato;
    }
    data['comentario'] = this.comentario.toString();
    data['tipePay'] = this.tipePay.toString();
    data['url'] = this.url.toString();
    return data;
  }
}