import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/models/failure.dart';
import 'package:shop_app/domain/usecase/base_usecase.dart';

import '../models/product.dart';
import '../repository/repository.dart';

class GetProductsUseCase extends BaseUseCase<String, List<Product>> {
  final Repository _repository;
  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> excute(String input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.getProducts(token!, input);
  }
}
