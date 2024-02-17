import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  final String userId;
  final String expiryDate;
  final String token;
  const Authentication(
    this.userId,
    this.expiryDate,
    this.token,
  );

  @override
  List<Object> get props => [userId, expiryDate, token];
}

class AuthRequest {
  String email;
  String password;
  AuthRequest(this.email, this.password);
}
