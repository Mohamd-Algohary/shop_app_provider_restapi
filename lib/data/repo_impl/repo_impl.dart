import 'package:dartz/dartz.dart';

import '../../domain/models/cart.dart';
import '/domain/models/order.dart';
import '/data/api/error_handler.dart';
import '/data/mapper/mapper.dart';
import '/domain/models/product.dart';
import '/domain/models/auth.dart';
import '/domain/models/failure.dart';
import '../../domain/repository/repository.dart';
import '../api/network_info.dart';
import '../data_scource/remote_data_source.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      String email, String password) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.login(email, password);
        return Right(res.toDomain());
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      String email, String password) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.register(email, password);
        return Right(res.toDomain());
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

//!-----------------------------------------------------------------------------
  @override
  Future<Either<Failure, String>> addProduct(
      String token, String userId, Product product) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.addProduct(token, userId, product);

        return Right(res.values.first);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateProduct(
      String token, String prodId, Product product) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.updateProduct(token, prodId, product);

        return Right(res.values.first);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

//!-----------------------------------------------------------------------------
  @override
  Future<Either<Failure, List<Product>>> getProducts(
      String token, String filter) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.getProducts(token, filter);

        return Right(res?.toDomain().values.toList() ?? []);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>> getUserFavorites(
      String token, String userId) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.getUserFavorites(token, userId);

        return Right(res ?? <String, bool>{});
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> toggelFavoriteStatus(
      bool isFavorite, String token, String userId, String productId) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.toggelFavoriteStatus(
            token, userId, productId, isFavorite);
        return Right(res);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

//!-----------------------------------------------------------------------------
  @override
  Future<Either<Failure, List<OrderItem>?>> fetchOrders(
      String token, String userId) async {
    try {
      var res = await _remoteDataSource.fetchOrders(token, userId);

      return Right(res?.toDomain().values.toList());
    } catch (err) {
      return Left(ErrorHandler.handler(err).failure);
    }
  }

  @override
  Future<Either<Failure, String>> addOrder(String token, String userId,
      List<CartProduct> cartProducts, double amount, String dateTime) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.addOrder(
            token, userId, cartProducts, amount, dateTime);

        return Right(res.values.first);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateOrder(
      String token,
      String userId,
      String orderId,
      List<CartProduct> cartProducts,
      double amount,
      String dateTime) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.updateOrder(
            token, userId, orderId, cartProducts, amount, dateTime);

        return Right(res.values.first);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(
      String orderId, String token, String userId) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.deleteOrder(token, userId, orderId);

        return Right(res);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

//!-----------------------------------------------------------------------------
  @override
  Future<Either<Failure, void>> deleteProduct(
      String token, String prodId) async {
    if (await _networkInfo.isConnected()) {
      try {
        var res = await _remoteDataSource.deleteProduct(token, prodId);

        return Right(res);
      } catch (err) {
        return Left(ErrorHandler.handler(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
