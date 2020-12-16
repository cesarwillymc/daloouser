// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CarritoPriceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarritoPriceModelAdapter extends TypeAdapter<CarritoPriceModel> {
  @override
  final int typeId = 7;

  @override
  CarritoPriceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarritoPriceModel(
      fields[0] as double,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarritoPriceModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.Precio)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarritoPriceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
