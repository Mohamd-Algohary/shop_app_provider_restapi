import '/domain/models/cart.dart';
import '/data/api/auth_api.dart';
import '/data/api/data_api.dart';
import '/data/response/response.dart';
import '/domain/models/product.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(String email, String password);
  Future<AuthenticationResponse> register(String email, String password);

  Future<Map<String, String>> addProduct(
      String token, String userId, Product product);
  Future<Map<String, String>> updateProduct(
      String token, String prodId, Product product);

  Future<ProductResponse?> getProducts(String token, String filter);
  Future<Map<String, bool>?> getUserFavorites(String token, String userId);
  Future<bool> toggelFavoriteStatus(
      String token, String userId, String productId, bool isFavorite);

  Future<OrderItemResponse?> fetchOrders(String token, String userId);
  Future<Map<String, String>> addOrder(String token, String userId,
      List<CartProduct> cartProducts, double amount, String dateTime);
  Future<Map<String, String>> updateOrder(
      String token,
      String userId,
      String orderId,
      List<CartProduct> cartProducts,
      double amount,
      String dateTime);
  Future<void> deleteOrder(String token, String userId, String orderId);

  Future<void> deleteProduct(String token, String prodId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AuthAppServiceClient _appServiceClient;
  final DataAppServiceClient _dataServiceClient;
  RemoteDataSourceImpl(this._appServiceClient, this._dataServiceClient);

  @override
  Future<AuthenticationResponse> login(String email, String password) async {
    return await _appServiceClient.login(email, password, true);
  }

  @override
  Future<AuthenticationResponse> register(String email, String password) async {
    return await _appServiceClient.register(email, password, true);
  }

//!-----------------------------------------------------------------------------
  @override
  Future<Map<String, String>> addProduct(
      String token, String userId, Product product) async {
    return await _dataServiceClient.addProduct(token, product.title!,
        product.description!, product.price!, product.imageUrl!, userId);
  }

  @override
  Future<Map<String, String>> updateProduct(
      String token, String prodId, Product product) async {
    return await _dataServiceClient.updateProduct(token, prodId, product.title!,
        product.description!, product.price!, product.imageUrl!);
  }

//!-----------------------------------------------------------------------------
  @override
  Future<ProductResponse?> getProducts(String token, String filter) async {
    return await _dataServiceClient.getProducts(token, filter);
  }

  @override
  Future<Map<String, bool>?> getUserFavorites(
      String token, String userId) async {
    return await _dataServiceClient.getUserFavorites(token, userId);
  }

  @override
  Future<bool> toggelFavoriteStatus(
      String token, String userId, String productId, bool isFavorite) async {
    return await _dataServiceClient.toggelFavoriteStatus(
        token, userId, productId, isFavorite);
  }

//!-----------------------------------------------------------------------------
  @override
  Future<OrderItemResponse?> fetchOrders(String token, String userId) async {
    return await _dataServiceClient.fetchOrders(token, userId);
  }

  @override
  Future<Map<String, String>> addOrder(String token, String userId,
      List<CartProduct> cartProducts, double amount, String dateTime) async {
    return await _dataServiceClient.addOrder(
        token, userId, cartProducts, amount, dateTime);
  }

  @override
  Future<Map<String, String>> updateOrder(
      String token,
      String userId,
      String orderId,
      List<CartProduct> cartProducts,
      double amount,
      String dateTime) async {
    return await _dataServiceClient.updateOrder(
        token, userId, orderId, cartProducts, amount, dateTime);
  }

  @override
  Future<void> deleteOrder(String token, String userId, String orderId) async {
    return await _dataServiceClient.deleteOrder(token, userId, orderId);
  }

//!-----------------------------------------------------------------------------
  @override
  Future<void> deleteProduct(String token, String prodId) async {
    return await _dataServiceClient.deleteProduct(token, prodId);
  }
}
