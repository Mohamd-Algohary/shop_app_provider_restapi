import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class GetUserFavUseCase extends BaseUseCase<void, Map<String, bool>> {
  final Repository _repository;
  GetUserFavUseCase(this._repository);

  @override
  Future<Either<Failure, Map<String, bool>>> excute(void input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.getUserFavorites(token!, userId!);
  }
}
