// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderProductAdapter extends TypeAdapter<OrderProduct> {
  @override
  final int typeId = 6;

  @override
  OrderProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderProduct(
      idProduct: fields[5] as ProductResponse?,
      optionsSize: fields[1] as OptionsSize?,
      optionsTopping: (fields[2] as List?)?.cast<OptionsTopping>(),
      amount: fields[3] as int?,
      price: fields[4] as double?,
      id: fields[0] as String?,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderProduct obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.optionsSize)
      ..writeByte(2)
      ..write(obj.optionsTopping)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.idProduct)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
