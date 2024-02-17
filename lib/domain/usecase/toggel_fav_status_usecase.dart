import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class ToggelFavStatusUseCase extends BaseUseCase<bool, bool> {
  final Repository _repository;
  ToggelFavStatusUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> excute(bool input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.toggelFavoriteStatus(
        input, token!, userId!, prodId!);
  }
}
