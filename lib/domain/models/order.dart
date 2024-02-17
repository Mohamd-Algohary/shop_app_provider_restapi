import 'package:json_annotation/json_annotation.dart';

import '/domain/models/cart.dart';
part 'order.g.dart';

@JsonSerializable()
class OrderItem {
  String? id;
  double? amount;
  List<CartProduct>? products;
  DateTime? dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
