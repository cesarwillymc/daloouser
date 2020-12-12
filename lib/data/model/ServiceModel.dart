class ServiceModel {
  String id;
  String name;
  String address;
  double latitude;
  double longitude;
  double altitude;
  String category;
  String description;
  String horario;
  bool activeAccount;
  bool isOpen;
  String imagen;
  String serviceId;
  String categoriaId;

  ServiceModel(
      {
        this.id,
        this.name,
        this.address,
        this.latitude,
        this.longitude,
        this.altitude,
        this.category,
        this.description,
        this.horario,
        this.activeAccount,
        this.isOpen,
        this.imagen,
        this.serviceId,
        this.categoriaId});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    category = json['category'];
    description = json['description'];
    horario = json['horario'];
    activeAccount = json['activeAccount'];
    isOpen = json['isOpen'];
    imagen = json['imagen'];
    serviceId = json['serviceId'];
    categoriaId = json['categoriaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['category'] = this.category;
    data['description'] = this.description;
    data['horario'] = this.horario;
    data['activeAccount'] = this.activeAccount;
    data['isOpen'] = this.isOpen;
    data['imagen'] = this.imagen;
    data['serviceId'] = this.serviceId;
    data['categoriaId'] = this.categoriaId;
    return data;
  }
}