import 'package:hive/hive.dart';

class PromocionesModel{
  String nameProduct;
  String img;
  String price;
  String rating;
  String timePrepare;
  String nameService;
  String serviceId;
  String productId;

  PromocionesModel(this.nameProduct, this.img, this.price, this.rating, this.timePrepare, this.nameService, this.serviceId, this.productId);
  PromocionesModel.fromJson(Map<String, dynamic> json){
    nameProduct= json["nameProduct"].toString();
    img= json["img"].toString();
    price= json["price"].toString();
    rating= json["rating"].toString();
    timePrepare= json["timePrepare"].toString();
    nameService= json["nameService"].toString();
    serviceId= json["serviceId"].toString();
    productId= json["productId"].toString();
  }
}