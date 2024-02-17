import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/app/constants.dart';
import '/data/response/response.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthAppServiceClient {
  factory AuthAppServiceClient(Dio dio, {String baseUrl}) =
      _AuthAppServiceClient;

  @POST("signInWithPassword?key=AIzaSyCUk3auUMYCKe6-2IbucdY3HWz8UdzMFVk")
  Future<AuthenticationResponse> login(
      @Field('email') String email,
      @Field('password') String password,
      @Field('returnSecureToken') bool returnSecureToken);

  @POST("signUp?key=AIzaSyCUk3auUMYCKe6-2IbucdY3HWz8UdzMFVk")
  Future<AuthenticationResponse> register(
      @Field('email') String email,
      @Field('password') String password,
      @Field('returnSecureToken') bool returnSecureToken);
}
