import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class DeleteProductUseCase extends BaseUseCase<String, void> {
  final Repository _repository;
  DeleteProductUseCase(this._repository);

  @override
  Future<Either<Failure, void>> excute(String input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.deleteProduct(token!, input);
  }
}
