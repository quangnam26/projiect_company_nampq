// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_product_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupProductResponseAdapter extends TypeAdapter<GroupProductResponse> {
  @override
  final int typeId = 9;

  @override
  GroupProductResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupProductResponse(
      id: fields[0] as String?,
      position: fields[1] as int?,
      name: fields[2] as String?,
      idUser: fields[3] as UserResponse?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GroupProductResponse obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.idUser)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupProductResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
