import 'dart:convert';

import 'package:hive/hive.dart';

import 'ProductoData.dart';
import 'ServiceModel.dart';

part 'ListaProductosCategoria.g.dart';
@HiveType(typeId: 2)
class ListaProductosCategoria {
  @HiveField(0)
  ServiceModel service;
  @HiveField(1)
  List<ProductoData> items;

  ListaProductosCategoria(this.service, this.items);

  ListaProductosCategoria.fromJson(Map<String, dynamic> data){
    service =
    data['service'] != null ? new ServiceModel.fromJson(data['service']) : null;
    if (data['items'] != null) {
      items = new List<ProductoData>();
      data['items'].forEach((v) {
        items.add(new ProductoData.fromJson(v));
      });
    }
  //  service= ServiceModel.fromJson(data["service"]);

//    items=  List<ProductoData>.from(json.decode(data["items"]).map((x)=>ProductoData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
