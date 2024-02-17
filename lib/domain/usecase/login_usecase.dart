import 'package:dartz/dartz.dart';

import '/domain/models/auth.dart';
import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class LoginUseCase extends BaseUseCase<AuthRequest, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> excute(AuthRequest input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.login(input.email, input.password);
  }
}
