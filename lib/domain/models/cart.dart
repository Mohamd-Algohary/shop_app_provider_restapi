import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class CartProduct extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int quantity;
  @HiveField(3)
  double? price;
  @HiveField(4)
  String? imageUrl;

  CartProduct({
    required this.id,
    required this.title,
    this.quantity = 0,
    required this.price,
    required this.imageUrl,
  });
  Map<String, dynamic> toJson() => _$CartProductToJson(this);

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
}
