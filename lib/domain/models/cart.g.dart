// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductAdapter extends TypeAdapter<CartProduct> {
  @override
  final int typeId = 0;

  @override
  CartProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProduct(
      id: fields[0] as String?,
      title: fields[1] as String?,
      quantity: fields[2] as int,
      price: fields[3] as double?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartProduct obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
      id: json['id'] as String?,
      title: json['title'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'quantity': instance.quantity,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
    };
