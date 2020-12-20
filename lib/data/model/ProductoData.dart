import 'dart:convert';

import 'package:daloouser/data/model/Prices.dart';
import 'package:hive/hive.dart';

part 'ProductoData.g.dart';
@HiveType(typeId: 11)
class ProductoData{
  @HiveField(0)
  String id;
  @HiveField(1)
  String namePriceGeneral;
  @HiveField(2)
  bool status;
  @HiveField(3)
  String subcategoryId;
  @HiveField(4)
  String name;
  @HiveField(5)
  String description;
  @HiveField(6)
  String timePrepare;
  @HiveField(7)
  double priceGeneral;
  @HiveField(8)
  String serviceId;
  @HiveField(9)
  String img;
  @HiveField(10)
  String img2;
  @HiveField(11)
  String subcategory;
  @HiveField(12)
  List<Prices> prices=new List<Prices>();

  //Other
  @HiveField(13)
  String servicename;
  @HiveField(14)
  String address;
  @HiveField(15)
  String horario;
  @HiveField(16)
  double longitude;
  @HiveField(17)
  double latitude;
  @HiveField(18)
  double rating;
  @HiveField(19)
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