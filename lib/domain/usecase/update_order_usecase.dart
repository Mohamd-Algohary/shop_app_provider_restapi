import 'package:dartz/dartz.dart';

import '../models/order.dart';
import '/domain/models/failure.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class UpdateOrderUseCase extends BaseUseCase<OrderItem, String> {
  final Repository _repository;
  UpdateOrderUseCase(this._repository);

  @override
  Future<Either<Failure, String>> excute(OrderItem input,
      {String? token, String? userId, String? prodId}) async {
    return await _repository.updateOrder(token!, userId!, input.id!,
        input.products!, input.amount!, input.dateTime!.toIso8601String());
  }
}
