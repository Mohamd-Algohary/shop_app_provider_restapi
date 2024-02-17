import 'package:dartz/dartz.dart';

import '../models/cart.dart';
import '/domain/models/order.dart';
import '../models/product.dart';
import '/domain/models/auth.dart';
import '../models/failure.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(String email, String password);
  Future<Either<Failure, Authentication>> register(
      String email, String password);

  Future<Either<Failure, String>> addProduct(
      String token, String userId, Product product);
  Future<Either<Failure, String>> updateProduct(
      String token, String prodId, Product product);

  Future<Either<Failure, List<Product>>> getProducts(
      String token, String filter);
  Future<Either<Failure, Map<String, bool>>> getUserFavorites(
      String token, String userId);
  Future<Either<Failure, bool>> toggelFavoriteStatus(
      bool isFavorite, String token, String userId, String productId);

  Future<Either<Failure, List<OrderItem>?>> fetchOrders(
      String token, String userId);
  Future<Either<Failure, String>> addOrder(String token, String userId,
      List<CartProduct> cartProducts, double amount, String dateTime);
  Future<Either<Failure, String>> updateOrder(
      String token,
      String userId,
      String orderId,
      List<CartProduct> cartProducts,
      double amount,
      String dateTime);
  Future<Either<Failure, void>> deleteOrder(
      String orderId, String token, String userId);

  Future<Either<Failure, void>> deleteProduct(String token, String prodId);
}
