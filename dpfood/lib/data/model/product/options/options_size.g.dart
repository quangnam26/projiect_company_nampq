// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_size.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionsSizeAdapter extends TypeAdapter<OptionsSize> {
  @override
  final int typeId = 11;

  @override
  OptionsSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionsSize(
      size: fields[4] as String?,
    )
      ..id = fields[0] as String?
      ..price = fields[1] as double?
      ..createdAt = fields[2] as String?
      ..updatedAt = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, OptionsSize obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.size)
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
      other is OptionsSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
