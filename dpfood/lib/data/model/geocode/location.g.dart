// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 13;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      lat: fields[0] as String?,
      long: fields[1] as String?,
      startLat: fields[4] as String?,
      startLong: fields[5] as String?,
      endLat: fields[6] as String?,
      endLong: fields[7] as String?,
      lng: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(4)
      ..write(obj.startLat)
      ..writeByte(5)
      ..write(obj.startLong)
      ..writeByte(6)
      ..write(obj.endLat)
      ..writeByte(7)
      ..write(obj.endLong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
