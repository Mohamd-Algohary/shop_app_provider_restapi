import 'package:freezed_annotation/freezed_annotation.dart';

import '/domain/models/cart.dart';
import '/domain/models/order.dart';
import '../../domain/models/product.dart';

part 'response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name: "localId")
  String? userId;
  @JsonKey(name: "idToken")
  String? token;
  @JsonKey(name: "expiresIn")
  String? expiryDate;
  AuthenticationResponse(
    this.userId,
    this.token,
    this.expiryDate,
  );

  factory AuthenticationResponse.fromJson(json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ProductResponse {
  final Map<String, Product> products;
  ProductResponse({required this.products});

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}

@JsonSerializable()
class CartProductResponse {
  final Map<String, CartProduct> products;

  CartProductResponse({required this.products});

  Map<String, dynamic> toJson() => _$CartProductResponseToJson(this);

  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CartProductResponseFromJson(json);
}

@JsonSerializable()
class OrderItemResponse {
  final Map<String, OrderItem> orderItem;

  OrderItemResponse({required this.orderItem});

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseFromJson(json);
}
