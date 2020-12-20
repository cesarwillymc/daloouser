class HistoryModel {
  String idOrder;
  int date;
  String nameUserOrder;
  String userPhone;
  String coment;
  String riderPrice;
  String itemsPrice;
  int cantTotal;
  String direcction;
  List<Items> items;
  String idUser;
  String referenciaUser;
  String nameServiceOrder;
  String pdf;

  HistoryModel(
      {this.idOrder,
        this.date,
        this.nameUserOrder,
        this.userPhone,
        this.coment,
        this.riderPrice,
        this.itemsPrice,
        this.cantTotal,
        this.direcction,
        this.items,
        this.idUser,
        this.referenciaUser,
        this.nameServiceOrder,
        this.pdf});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    idOrder = json['idOrder'];
    date = int.parse(json['date'].toString());
    nameUserOrder = json['nameUserOrder'];
    userPhone = json['userPhone'];
    coment = json['coment'];
    riderPrice = json['riderPrice'];
    itemsPrice = json['itemsPrice'];
    cantTotal = int.parse(json['cantTotal'].toString());
    direcction = json['direcction'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    idUser = json['idUser'];
    referenciaUser = json['referenciaUser'];
    nameServiceOrder = json['nameServiceOrder'];
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrder'] = this.idOrder;
    data['date'] = this.date;
    data['nameUserOrder'] = this.nameUserOrder;
    data['userPhone'] = this.userPhone;
    data['coment'] = this.coment;
    data['riderPrice'] = this.riderPrice;
    data['itemsPrice'] = this.itemsPrice;
    data['cantTotal'] = this.cantTotal;
    data['direcction'] = this.direcction;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['idUser'] = this.idUser;
    data['referenciaUser'] = this.referenciaUser;
    data['nameServiceOrder'] = this.nameServiceOrder;
    data['pdf'] = this.pdf;
    return data;
  }
}

class Items {
  String name;
  String subname;
  double price;
  int cant;
  double totalPrice;

  Items({this.name, this.subname, this.price, this.cant, this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subname = json['subname'];
    price = double.parse(json['price'].toString());
    cant = int.parse(json['cant'].toString());
    totalPrice = double.parse(json['totalPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subname'] = this.subname;
    data['price'] = this.price;
    data['cant'] = this.cant;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}