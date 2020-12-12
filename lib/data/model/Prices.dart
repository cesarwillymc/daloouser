class Prices{
  String id;
  double price;
  String name;
  String desc;
  String id2;

  Prices(this.id, this.price, this.name, this.desc, this.id2);

  Prices.fromJson(Map<String, dynamic> json){
    id= json["_id"].toString();
    price= double.parse(json["price"].toString());
    name= json["name"].toString();
    desc= json["desc"].toString();
  }
}