// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModelAdapter extends TypeAdapter<ServiceModel> {
  @override
  final int typeId = 10;

  @override
  ServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      altitude: fields[5] as double,
      category: fields[6] as String,
      description: fields[7] as String,
      horario: fields[8] as String,
      activeAccount: fields[9] as bool,
      isOpen: fields[10] as bool,
      imagen: fields[11] as String,
      serviceId: fields[12] as String,
      categoriaId: fields[13] as String,
      ratingNumber: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.altitude)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.horario)
      ..writeByte(9)
      ..write(obj.activeAccount)
      ..writeByte(10)
      ..write(obj.isOpen)
      ..writeByte(11)
      ..write(obj.imagen)
      ..writeByte(12)
      ..write(obj.serviceId)
      ..writeByte(13)
      ..write(obj.categoriaId)
      ..writeByte(14)
      ..write(obj.ratingNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
