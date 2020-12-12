
import 'package:hive/hive.dart';
part 'CategoryModel.g.dart';
@HiveType()
class CategoryModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String img;

  CategoryModel(this.id, this.img);
  CategoryModel.fromJson(Map<String, dynamic> json){
    id= json["_id"].toString();
    img= json["img"].toString();
  }


}