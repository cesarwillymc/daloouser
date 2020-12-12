import 'package:hive/hive.dart';
part 'PromocionesModel.g.dart';

@HiveType()
class PromocionesModel{
  @HiveField(0)
  String nameProduct;
  @HiveField(1)
  String img;
  @HiveField(2)
  String price;
  @HiveField(3)
  String rating;
  @HiveField(4)
  String timePrepare;
  @HiveField(5)
  String nameService;
  @HiveField(6)
  String serviceId;
  @HiveField(7)
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