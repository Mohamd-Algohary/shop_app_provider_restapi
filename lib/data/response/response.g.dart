// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['localId'] as String?,
      json['idToken'] as String?,
      json['expiresIn'] as String?,
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'localId': instance.userId,
      'idToken': instance.token,
      'expiresIn': instance.expiryDate,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      products: (json).map(
        (k, e) => MapEntry(k, Product.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

CartProductResponse _$CartProductResponseFromJson(Map<String, dynamic> json) =>
    CartProductResponse(
      products: (json['products'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, CartProduct.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$CartProductResponseToJson(
        CartProductResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

OrderItemResponse _$OrderItemResponseFromJson(Map<String, dynamic> json) =>
    OrderItemResponse(
      orderItem: (json).map(
        (k, e) => MapEntry(k, OrderItem.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$OrderItemResponseToJson(OrderItemResponse instance) =>
    <String, dynamic>{
      'orderItem': instance.orderItem,
    };
