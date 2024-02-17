import '/app/extention.dart';
import '/domain/models/cart.dart';
import '/domain/models/order.dart';
import '/domain/models/product.dart';
import '/data/response/response.dart';
import '/domain/models/auth.dart';

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(
        userId.orEmpty(), expiryDate.orEmpty(), token.orEmpty());
  }
}

extension ProductResponseMapper on ProductResponse {
  Map<String, Product> toDomain() {
    return products.map((key, value) => MapEntry(
        key,
        Product(
            id: key.orEmpty(),
            title: value.title.orEmpty(),
            description: value.description.orEmpty(),
            price: value.price.orZero(),
            imageUrl: value.imageUrl.orEmpty())));
  }
}

extension CartProductResponseMapper on CartProductResponse {
  Map<String, CartProduct> toDomain() {
    return products.map((key, value) => MapEntry(
        key,
        CartProduct(
            id: value.id.orEmpty(),
            title: value.title.orEmpty(),
            quantity: value.quantity.orZero(),
            price: value.price.orZero(),
            imageUrl: value.imageUrl.orEmpty())));
  }
}

extension OrderItemResponseMapper on OrderItemResponse {
  Map<String, OrderItem> toDomain() {
    return orderItem.map((key, value) => MapEntry(
        key,
        OrderItem(
            id: key.orEmpty(),
            amount: value.amount.orZero(),
            products: value.products ?? [],
            dateTime: value.dateTime.dateTimeNow())));
  }
}
