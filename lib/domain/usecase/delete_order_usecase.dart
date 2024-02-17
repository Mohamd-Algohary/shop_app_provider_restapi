import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class DeleteOrderUseCase extends BaseUseCase<String, void> {
  final Repository _repository;
  DeleteOrderUseCase(this._repository);

  @override
  Future<Either<Failure, void>> excute(String input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.deleteOrder(input, token!, userId!);
  }
}
