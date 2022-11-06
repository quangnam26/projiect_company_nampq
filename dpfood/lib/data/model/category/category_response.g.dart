// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryResponseAdapter extends TypeAdapter<CategoryResponse> {
  @override
  final int typeId = 8;

  @override
  CategoryResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryResponse(
      id: fields[0] as String?,
      isShow: fields[1] as bool?,
      position: fields[2] as int?,
      thumbnail: fields[3] as String?,
      name: fields[4] as String?,
      color: fields[5] as String?,
      createdAt: fields[6] as String?,
      updatedAt: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryResponse obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isShow)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
