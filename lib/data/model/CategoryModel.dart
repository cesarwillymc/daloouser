
import 'package:hive/hive.dart';
part 'CategoryModel.g.dart';
@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String img;
  @HiveField(2)
  int total;

  CategoryModel(this.id, this.img,this.total);
  CategoryModel.fromJson(Map<String, dynamic> json){
    id= json["_id"].toString();
    img= json["img"].toString();
    total= int.parse(json["total"].toString());
  }


}