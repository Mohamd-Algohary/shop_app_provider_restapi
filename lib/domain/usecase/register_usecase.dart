import 'package:dartz/dartz.dart';

import '/domain/models/auth.dart';
import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class RegisterUseCase extends BaseUseCase<AuthRequest, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> excute(AuthRequest input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.register(input.email, input.password);
  }
}
