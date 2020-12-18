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
      data['listadepedidos'] = this.listadepedidos.map((v) => v.toJson()).toList();
    }
    data['comentario'] = this.comentario;
    data['tipePay'] = this.tipePay;
    data['url'] = this.url;
    return data;
  }
}