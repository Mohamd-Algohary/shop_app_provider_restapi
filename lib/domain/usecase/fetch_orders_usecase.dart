import 'package:dartz/dartz.dart';

import '../models/order.dart';
import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class FetchOrdersUseCase extends BaseUseCase<void, List<OrderItem>?> {
  final Repository _repository;
  FetchOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, List<OrderItem>?>> excute(void input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.fetchOrders(token!, userId!);
  }
}
