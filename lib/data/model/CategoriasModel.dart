class CategoriasModel {
  String id;
  String name;
  CategoriasModel(this.name,this.id);
  CategoriasModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['_id'];
  }
}