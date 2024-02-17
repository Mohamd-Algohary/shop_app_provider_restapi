import 'package:dartz/dartz.dart';

import '/domain/models/failure.dart';
import '/domain/models/product.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class UpdateProductUseCase extends BaseUseCase<Product, String> {
  final Repository _repository;
  UpdateProductUseCase(this._repository);

  @override
  Future<Either<Failure, String>> excute(Product input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.updateProduct(token!, prodId!, input);
  }
}
