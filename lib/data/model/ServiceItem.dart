import 'package:hive/hive.dart';

part 'ServiceItem.g.dart';

@HiveType()
class ServiceItem {
  @HiveField(0)
  String category;
  @HiveField(1)
  String id;
  @HiveField(2)
  String _id;
  @HiveField(3)
  String img;
  @HiveField(4)
  String name;
  @HiveField(5)
  String address;
  @HiveField(6)
  bool isOpen;
  @HiveField(7)
  bool isProduct;
  @HiveField(8)
  String ratingNumber;
  @HiveField(9)
  String categoryId;
  @HiveField(10)
  String categoriaId;
  @HiveField(11)
  String namedRest;
  @HiveField(12)
  int idNumber;
  ServiceItem(this.category, this.id, this._id, this.img, this.name, this.address, this.isOpen, this.isProduct, this.ratingNumber, this.categoryId, this.categoriaId, this.namedRest,this.idNumber);

  factory ServiceItem.fromMap(Map<String, dynamic> data) => new ServiceItem(
    data["category"].toString(),
    data["id"].toString(),
    data["_id"].toString(),
    data["img"].toString(),
    data["name"].toString(),
    data["address"].toString(),
    (data["isOpen"] as bool),
    (data["isProduct"] as bool),
    data["ratingNumber"].toString(),
    data["categoryId"].toString(),
    data["categoriaId"].toString(),
    data["namedRest"].toString(),
    int.parse(data["idNumber"])
  );
  ServiceItem.fromJson(Map<String, dynamic> json){
    category= json["category"].toString();
    id= json["id"].toString();
    img= json["img"].toString();
    name= json["name"].toString();
    address= json["address"].toString();
    isOpen= json["isOpen"] as bool;
    isProduct= json["isProduct"] as bool;
    ratingNumber= json["ratingNumber"].toString();
    categoryId= json["categoryId"].toString();
    namedRest= json["namedRest"].toString();
  }
  ServiceItem.fromJson2(Map<String, dynamic> json){
    category= json["category"].toString();
    _id= json["_id"].toString();
    img= json["img"].toString();
    name= json["name"].toString();
    address= json["address"].toString();
    isOpen= json["isOpen"] as bool;
    isProduct= json["isProduct"] as bool;
    ratingNumber= json["ratingNumber"].toString();
    categoryId= json["categoryId"].toString();
    namedRest= json["namedRest"].toString();
  }
  factory ServiceItem.fromJsonSearch(Map<dynamic, dynamic> json) => new ServiceItem(
    json["category"].toString(),
    json["id"].toString(),
    null,
    json["img"].toString(),
    json["name"].toString(),
    json["address"].toString(),
    (json["isOpen"] as bool),
    (json["isProduct"] as bool),
    json["ratingNumber"].toString(),
    json["categoryId"].toString(),
    null,
    json["namedRest"].toString(),
    int.parse(json["idNumber"])
  );
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'id': id,
      '_id': _id,
      'img': img,
      'name': name,
      'address': address,
      'isOpen': isOpen,
      'isProduct': isProduct,
      'ratingNumber': ratingNumber,
      'categoryId': categoryId,
      'categoriaId': categoriaId,
      'namedRest': namedRest,
      'idNumber': idNumber,
    };
  }
}