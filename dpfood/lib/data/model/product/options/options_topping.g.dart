// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_topping.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionsToppingAdapter extends TypeAdapter<OptionsTopping> {
  @override
  final int typeId = 12;

  @override
  OptionsTopping read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionsTopping(
      topping: fields[4] as String?,
    )
      ..id = fields[0] as String?
      ..price = fields[1] as double?
      ..createdAt = fields[2] as String?
      ..updatedAt = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, OptionsTopping obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.topping)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionsToppingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
