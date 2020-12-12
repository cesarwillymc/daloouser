import 'dart:convert';

import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/data/model/ListServices.dart';
import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/data/model/PromocionesModel.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:http/http.dart' as http;

class MainRepository{
  Future<List<ServiceItem>> searchProducts(String palabra) async {
    final String url="customer/search";
    var palabraUrl=BASE_URL_API+url+"?buscar="+palabra;
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      return List<ServiceItem>.from(json.decode(response.body).map((x)=>ServiceItem.fromJson(x)));
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<List<CategoryModel>> getCategoriasProducts() async {
    final String url="customer/categories";
    var palabraUrl=BASE_URL_API+url;
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      return List<CategoryModel>.from(json.decode(response.body).map((x)=>CategoryModel.fromJson(x)));
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<List<PromocionesModel>> getPromociones() async {
    final String url="customer/carousel";
    var palabraUrl=BASE_URL_API+url;
    final response =await http.get(palabraUrl);
    print("Promociones ${response.body} ${response.body.length}");

    if(response.statusCode==200){
      return response.body.length!=0?List<PromocionesModel>.from(json.decode(response.body).map((x)=>PromocionesModel.fromJson(x))):[];
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<List<ListaProductosCategoria>> getListProductswithService() async {
    final String url="customer/byCategoriesMain";
    var palabraUrl=BASE_URL_API+url;
    final response =await http.get(palabraUrl);

    if(response.statusCode==200){
      //List<ListaProductosCategoria>.from(json.decode(response.body).map((x)=>ListaProductosCategoria.fromJson(x)))
      return   await Stream.fromIterable(json.decode(response.body)).asyncMap((event) => new ListaProductosCategoria.fromJson(event)).toList();
    }else{
      throw Exception("Error en la red");
    }
  }


  //Get Producto Item
  Future<ProductoData> getProductByID(String id) async {
    final String url="customer/itemById/$id";

    var palabraUrl=BASE_URL_API+url;
    print("getProductByID $palabraUrl");
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      return ProductoData.fromJson2(json.decode(response.body));
    }else{
      throw Exception("Error en la red");
    }
  }
  //Get Producto Item
  Stream<ListServices> getServicesByCategory(String categoria,int desde) async* {
    final String url="customer/byCategories?desde=$desde&categoria=$categoria";

    var palabraUrl=BASE_URL_API+url;
    print("getServicesByCategory $palabraUrl");
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      var datos = await ListServices.fromJson(json.decode(response.body));
      yield datos;
    }else{
      throw Exception("Error en la red");
    }
  }
  //Get Service Info By Id
  Future<ServiceModel> getServiceInfoById(String id) async {
    final String url="customer/serviceInfo/$id";

    var palabraUrl=BASE_URL_API+url;
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      var datos = await ServiceModel.fromJson3(json.decode(response.body));
      return datos;
    }else{
      throw Exception("Error en la red");
    }
  }
}