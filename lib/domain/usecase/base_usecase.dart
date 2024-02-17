import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> excute(Input input,
      {String? token, String? userId, String? prodId});
}
