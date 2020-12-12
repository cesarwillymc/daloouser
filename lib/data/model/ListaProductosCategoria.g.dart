// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListaProductosCategoria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListaProductosCategoriaAdapter
    extends TypeAdapter<ListaProductosCategoria> {
  @override
  ListaProductosCategoria read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListaProductosCategoria(
      fields[0] as ServiceModel,
      (fields[1] as List)?.cast<ProductoData>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListaProductosCategoria obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.service)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get typeId => 4;
}
