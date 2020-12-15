class ListaProductItem {
  String sId;
  String name;
  String description;
  double priceGeneral;
  int total;
  String img;

  ListaProductItem({this.sId, this.name, this.description, this.priceGeneral, this.img,this.total});

  ListaProductItem.fromJson(Map<String, dynamic> json, int totalInt) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    priceGeneral = double.parse(json['priceGeneral'].toString());
    img = json['img'];
    total = totalInt;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['priceGeneral'] = this.priceGeneral;
    data['img'] = this.img;
    return data;
  }
}