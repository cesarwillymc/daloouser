class HistoryModelItem {
  String precio;
  int cantidad;
  String sId;
  Null fecha;

  HistoryModelItem({this.precio, this.cantidad, this.sId, this.fecha});

  HistoryModelItem.fromJson(Map<String, dynamic> json) {
    precio = json['precio'];
    cantidad = int.parse(json['cantidad'].toString());
    sId = json['_id'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precio'] = this.precio;
    data['cantidad'] = this.cantidad;
    data['_id'] = this.sId;
    data['fecha'] = this.fecha;
    return data;
  }
}