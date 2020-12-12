import 'dart:convert';

import 'package:daloouser/data/model/Prices.dart';

class ProductoData{
  String id;
  String namePriceGeneral;
  bool status;
  String subcategoryId;
  String name;
  String description;
  String timePrepare;
  double priceGeneral;
  String serviceId;
  String img;
  String img2;
  String subcategory;
  List<Prices> prices=new List<Prices>();

  //Other
  String servicename;
  String address;
  String horario;
  double longitude;
  double latitude;
  double rating;
  String itemname;



  ProductoData(this.id,
      this.namePriceGeneral,
      this.status,
      this.subcategoryId,
      this.name,
      this.description,
      this.timePrepare,
      this.priceGeneral,
      this.serviceId,
      this.img,
      this.img2,
      this.subcategory,
      this.prices,
      this.servicename,
      this.address,
      this.horario,
      this.longitude,
      this.latitude,
      this.rating,
      this.itemname,);

  ProductoData.fromJson(Map<String, dynamic> json){
    print("getListProductswithService product data ${json}");
    id = json['_id'];
    namePriceGeneral = json['namePriceGeneral'];
    status = json['status'] as bool;
    subcategoryId = json['subcategoryId'];
    name = json['name'];
    description = json['description'];
    timePrepare = json['timePrepare'];
    priceGeneral = double.parse(json['priceGeneral'].toString());
    serviceId = json['serviceId'];
    img = json['img'];
    img2 = json['img2'];
    subcategory = json['subcategory'];

  //  prices= List<Prices>.from(json.decode(data["prices"]).map((x)=>Prices.fromJson(x)));
  }
  ProductoData.fromJson2(Map<String, dynamic> data){
    serviceId = data['serviceId'];
    servicename = data['servicename'];
    address = data['address'];
    horario = data['horario'];
    longitude = double.parse(data['longitude'].toString());
    latitude = double.parse(data['latitude'].toString());
    rating = double.parse(data['rating'].toString());
    itemname = data['itemname'];
    description = data['description'];
    timePrepare = data['timePrepare'];
    priceGeneral = double.parse(data['priceGeneral'].toString()) ;
    namePriceGeneral = data['namePriceGeneral'];
    img = data['img'];
    if (data['prices'].toString().length>3) {
      data['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['namePriceGeneral'] = this.namePriceGeneral;
    data['status'] = this.status;
    data['subcategoryId'] = this.subcategoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['timePrepare'] = this.timePrepare;
    data['priceGeneral'] = this.priceGeneral;
    data['serviceId'] = this.serviceId;
    data['img'] = this.img;
    data['img2'] = this.img2;
    data['subcategory'] = this.subcategory;
    return data;
  }
}