// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CarritoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarritoModelAdapter extends TypeAdapter<CarritoModel> {
  @override
  final int typeId = 0;

  @override
  CarritoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarritoModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as double,
      fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CarritoModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idServicio)
      ..writeByte(1)
      ..write(obj.id_Product)
      ..writeByte(2)
      ..write(obj.id_Precio)
      ..writeByte(3)
      ..write(obj.nameService)
      ..writeByte(4)
      ..write(obj.cantidad)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.subName)
      ..writeByte(7)
      ..write(obj.imgUrl)
      ..writeByte(8)
      ..write(obj.precioTotal)
      ..writeByte(9)
      ..write(obj.precioUnitari);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarritoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
