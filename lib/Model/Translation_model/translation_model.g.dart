// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranclationModelAdapter extends TypeAdapter<TranclationModel> {
  @override
  final int typeId = 3;

  @override
  TranclationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranclationModel(
      catagry: fields[5] as CategoryModel,
      amount: fields[1] as double,
      categorytyp: fields[2] as categorytype,
      datetime: fields[3] as DateTime,
      not: fields[4] as String,
      id: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranclationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.categorytyp)
      ..writeByte(3)
      ..write(obj.datetime)
      ..writeByte(4)
      ..write(obj.not)
      ..writeByte(5)
      ..write(obj.catagry)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranclationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
