// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'products': instance.products,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
