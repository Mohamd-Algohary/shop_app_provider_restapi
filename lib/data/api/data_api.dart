import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/cart.dart';
import '../response/response.dart';
import '/app/constants.dart';

part 'data_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl2)
abstract class DataAppServiceClient {
  factory DataAppServiceClient(Dio dio, {String baseUrl}) =
      _DataAppServiceClient;

  @POST("products.json?auth={token}")
  Future<Map<String, String>> addProduct(
      @Path('token') String token,
      @Field('title') String title,
      @Field('description') String description,
      @Field('price') double price,
      @Field('imageUrl') String imageUrl,
      @Field('creatorId') String creatorId);

  @POST("products/{id}.json?auth={token}")
  Future<Map<String, String>> updateProduct(
    @Path('token') String token,
    @Path('id') String id,
    @Field('title') String title,
    @Field('description') String description,
    @Field('price') double price,
    @Field('imageUrl') String imageUrl,
  );

  @GET("products.json?auth={token}&{filter}")
  Future<ProductResponse?> getProducts(
    @Path('token') String token,
    @Path('filter') String filter,
  );

  @GET("userfavorites/{userId}.json?auth={token}")
  Future<Map<String, bool>?> getUserFavorites(
    @Path('token') String token,
    @Path('userId') String userId,
  );

  @PUT("userfavorites/{userId}/{productId}.json?auth={token}")
  Future<bool> toggelFavoriteStatus(
    @Path('token') String token,
    @Path('userId') String userId,
    @Path('productId') String productId,
    @Body() bool isFavorite,
  );

  @GET("orders/{userId}.json?auth={token}")
  Future<OrderItemResponse?> fetchOrders(
    @Path('token') String token,
    @Path('userId') String userId,
  );

  @POST("orders/{userId}.json?auth={token}")
  Future<Map<String, String>> addOrder(
    @Path('token') String token,
    @Path('userId') String userId,
    @Field('products')
    List<CartProduct>
        cartProducts, //cartProducts.map((e) => e.toJson()).toList()
    @Field('amount') double amount,
    @Field('dateTime') String dateTime,
  );

  @PATCH("orders/{userId}/{orderId}.json?auth={token}")
  Future<Map<String, String>> updateOrder(
    @Path('token') String token,
    @Path('userId') String userId,
    @Path('orderId') String orderId,
    @Field()
    List<CartProduct>
        cartProducts, //cartProducts.map((e) => e.toJson()).toList()
    @Field() double amount,
    @Field() String dateTime,
  );

  @DELETE("orders/{userId}/{orderId}.json?auth={token}")
  Future<void> deleteOrder(
    @Path('token') String token,
    @Path('userId') String userId,
    @Path('orderId') String orderId,
  );

  @DELETE("products/{id}.json?auth={token}")
  Future<void> deleteProduct(
    @Path('token') String token,
    @Path('id') String id,
  );
}
