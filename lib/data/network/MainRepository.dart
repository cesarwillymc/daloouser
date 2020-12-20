import 'dart:convert';
import 'dart:io';

import 'package:daloouser/data/model/CategoriasModel.dart';
import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/data/model/ComentariosModel.dart';
import 'package:daloouser/data/model/ComentariosStartModel.dart';
import 'package:daloouser/data/model/HistoryModel.dart';
import 'package:daloouser/data/model/HistoryModelItem.dart';
import 'package:daloouser/data/model/ListServices.dart';
import 'package:daloouser/data/model/ListaProducItem.dart';
import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/model/MapeoDepartamento.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/data/model/PromocionesModel.dart';
import 'package:daloouser/data/model/SendCarrito.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

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
  //Get Services Item
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

  //Get SUB CATEGORIA SPINNER
  Future<List<CategoriasModel>> getSubCategoriaSpinner(String id) async {
    final String url="customer/subcategorias/$id";

    var palabraUrl=BASE_URL_API+url;
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      var datos = await Stream.fromIterable(json.decode(response.body)).asyncMap((event) => new CategoriasModel.fromJson(event)).toList();
      return datos;
    }else{
      throw Exception("Error en la red");
    }
  }
  //Get producs By Categoria
  Future<List<ListaProductItem>> getProductsByCategoria(String categoria,int desde,String id) async {
    final String url="customer/categoryById/$id/?desde=$desde&tipe=$categoria";

    var palabraUrl=BASE_URL_API+url;
    print("getServicesByCategory $palabraUrl");
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){

      var datos = json.decode(response.body);

      var total = int.parse(datos["general"]['total'].toString());
      if (datos['lista'] != null) {
       return  await Stream.fromIterable(datos['lista']).asyncMap((event) => new ListaProductItem.fromJson(event,total)).toList();
      }else{
        return [];
      }
    }else{
      throw Exception("Error en la red");
    }
  }

   //Load Comentarios
  Future<List<ComentariosModel>> getComentariosServices(String id) async {
    final String url="customer/comentAndStarts/$id";

    var palabraUrl=BASE_URL_API+url;
    print("getServicesByCategory $palabraUrl");
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){

      var datos = json.decode(response.body);

      return  await Stream.fromIterable(datos).asyncMap((event) => new ComentariosModel.fromJson(event)).toList();
    }else{
      throw Exception("Error en la red");
    }
  }
  //Load Comentarios
  Future<List<ComentariosStartModel>> getComentariosStartServices(String id) async {
    final String url="customer/comentStarts/$id";

    var palabraUrl=BASE_URL_API+url;
    print("getServicesByCategory $palabraUrl");
    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      var datos = json.decode(response.body);

      return  await Stream.fromIterable(datos).asyncMap((event) => new ComentariosStartModel.fromJson(event)).toList();
    }else{
      throw Exception("Error en la red");
    }
  }
  //Get New Price
  Future<List<int>> getRutasGoogle(String ruta) async {
    final String url="https://maps.googleapis.com/$ruta";

    print("RutasGoogle $url");
    final response =await http.get(url);
    if(response.statusCode==200){

      var datos = json.decode(response.body);
      print("RutasGoogle  ${datos["routes"][0]["legs"]}");
      var time=0;
      var distance=0;
      await Stream.fromIterable(datos["routes"][0]["legs"]).forEach((element) {
        time+=int.parse(element["duration"]["value"].toString());
        distance+=int.parse(element["distance"]["value"].toString());
      });
      return [time,distance];
    }else{
      throw Exception("Error en la red");
    }
  }
  //Get New Price
  Future<bool> loginWithFacebookorGmail(String access,bool isFacebook) async {
    String url;
    if(isFacebook){
      url="login/facebook";
    }else{
      url="login/google";
    }
    var palabraUrl=BASE_URL_API+url;
    var cuerpo=loginFacebookJson(access,"");

    final response =await http.post(palabraUrl,body: cuerpo);
    if(response.statusCode==200){
      print("RutasGoogle cuerpo $cuerpo $palabraUrl acces token signin ${response.headers["authtoken"]}");
      if(response.headers["authtoken"]!=null){
        var shared= await SharedPreferences.getInstance();
        shared.setString(sharedPrefToken, response.headers["authtoken"].toString());
        return true;
      }
      return false;
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<UsuarioModel> getInformationUser() async {
    final String url="customer/information";

    var palabraUrl=BASE_URL_API+url;


    var shared= await SharedPreferences.getInstance();
    var token =shared.getString(sharedPrefToken);

    final response =await http.get(palabraUrl,headers: {HttpHeaders.authorizationHeader:token});
    if(response.statusCode==200){
      print("RutasGoogle $palabraUrl  $token");
      return UsuarioModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<MapeoDepartamento> getPoliline() async {
    final String url="user/maps";

    var palabraUrl=BASE_URL_API+url;

    final response =await http.get(palabraUrl);
    if(response.statusCode==200){
      var datos=MapeoDepartamento.fromJson(jsonDecode(response.body)[0]);

      return datos;
    }else{
      throw Exception("Error en la red");
    }
  }
  Future<bool> updateDirecctionUrl(String direccion, String referencia,double latitude,double longitud) async {
    final String url="customer/address";

    var palabraUrl=BASE_URL_API+url;

    var cuerpo=directionUserJson(direccion,referencia,latitude,longitud);
    print(cuerpo);
    var shared= await SharedPreferences.getInstance();
    var token =shared.getString(sharedPrefToken);


    final response =await http.put(palabraUrl,body: cuerpo,headers: {HttpHeaders.authorizationHeader:token} );
    print(palabraUrl);
    if(response.statusCode==200){
      return true;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<bool> sendProductsCarrito(SendCarrito model) async {
    final String url="customer/neworder";

    var palabraUrl=BASE_URL_API+url;

    var cuerpo=model.toJson();
    print("cuerpo ${jsonEncode(cuerpo)}");
    var shared= await SharedPreferences.getInstance();
    var token =shared.getString(sharedPrefToken);
    final response =await http.post(palabraUrl,body: jsonEncode(cuerpo),headers: {HttpHeaders.authorizationHeader:token,HttpHeaders.contentTypeHeader:"application/json"} );
    print(palabraUrl);
    if(response.statusCode==200){
      return true;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<bool> cancelOrderPedido() async {
    var idOrder= shared.getString(sharedPrefCARRITO_ID);
    final String url="customer/cancelOrder/$idOrder";
    var token =shared.getString(sharedPrefToken);
    var palabraUrl=BASE_URL_API+url;

    print("palabra $palabraUrl $token");
    final response =await http.post(palabraUrl,headers: {HttpHeaders.authorizationHeader:token,HttpHeaders.contentTypeHeader:"application/json"} );
    if(response.statusCode==200){
      return true;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<bool> terminarPedido() async {
    var idOrder=shared.getString(sharedPrefCARRITO_ID);
    var token =shared.getString(sharedPrefToken);
    final String url="customer/finishOrder/$idOrder";

    var palabraUrl=BASE_URL_API+url;

    print("palabra $palabraUrl $token");
    final response =await http.post(palabraUrl,headers: {HttpHeaders.authorizationHeader:token,HttpHeaders.contentTypeHeader:"application/json"} );
    if(response.statusCode==200){
      return true;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<bool> calificarRiderAndService(double calificacion, bool isrider, String id) async {

    String url;
    if(isrider){
      url="customer/riderRating/$id";
    }else{
      url="customer/serviceRating/$id";
    }
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.post(palabraUrl,body: calificacionJson(calificacion),headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      return true;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<List<HistoryModelItem>> getHistoryItems() async {

    String url="customer/orders";
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.get(palabraUrl,headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      var respuesta= await Stream.fromIterable(jsonDecode(response.body)).asyncMap((event) => new HistoryModelItem.fromJson(event)).toList();
      return respuesta;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<HistoryModel> getHistoryById(String id) async {

    String url="customer/orders/$id";
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.get(palabraUrl,headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      var respuesta= HistoryModel.fromJson(jsonDecode(response.body));
      return respuesta;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<String> descargarBoletaventa(String id) async {

    String url="customer/pdfOrder/$id";
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.get(palabraUrl,headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      var respuesta= jsonDecode(response.body)["message"];
      return respuesta;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }

  Future<String> sendMessagePhone(String phone) async {

    String url="customer/sendSMS";
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.post(palabraUrl,body: sendCodeJson(phone),headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      var respuesta= jsonDecode(response.body)["message"];
      return respuesta;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }
  Future<String> validateCodePhone(String phone,String code) async {

    String url="customer/validaSMS";
    var palabraUrl=BASE_URL_API+url;
    var token =shared.getString(sharedPrefToken);
    final response =await http.post(palabraUrl,body: validateCodeJson(phone,code),headers: {HttpHeaders.authorizationHeader:token} );
    if(response.statusCode==200){
      var respuesta= jsonDecode(response.body)["message"];
      return respuesta;
    }else{
      throw Exception("Error en la red ${response.statusCode}");
    }
  }

}