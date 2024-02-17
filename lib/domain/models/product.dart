import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
