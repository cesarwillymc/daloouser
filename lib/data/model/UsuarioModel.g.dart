// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UsuarioModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioModelAdapter extends TypeAdapter<UsuarioModel> {
  @override
  final int typeId = 4;

  @override
  UsuarioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsuarioModel(
      registerDate: fields[0] as String,
      accountActivated: fields[1] as bool,
      validateNumber: fields[2] as bool,
      uriImgPerfil: fields[3] as String,
      mobilePhone: fields[4] as String,
      name: fields[5] as String,
      lastName: fields[6] as String,
      latitude: fields[7] as double,
      longitude: fields[8] as double,
      altitude: fields[9] as int,
      address: fields[10] as String,
      idUser: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsuarioModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.registerDate)
      ..writeByte(1)
      ..write(obj.accountActivated)
      ..writeByte(2)
      ..write(obj.validateNumber)
      ..writeByte(3)
      ..write(obj.uriImgPerfil)
      ..writeByte(4)
      ..write(obj.mobilePhone)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude)
      ..writeByte(9)
      ..write(obj.altitude)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.idUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
