import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/presentation/common/base_viewmodel.dart';
import '../../cart_screen/viewmodel/viewmodel.dart';
import '/app/app_prefs.dart';
import '/presentation/common/error_message.dart';
import '../../../domain/models/cart.dart';
import '../../../domain/models/order.dart';
import '../../../domain/usecase/add_order_usecase.dart';
import '../../../domain/usecase/delete_order_usecase.dart';
import '../../../domain/usecase/fetch_orders_usecase.dart';
import '../../../domain/usecase/update_order_usecase.dart';

class OrdersViewModel extends BaseViewModel {
  final FetchOrdersUseCase _fetchOrdersUseCase;
  final AddOrderUseCase _addOrderUseCase;
  final UpdateOrderUseCase _updateOrderUseCase;
  final DeleteOrderUseCase _deleteOrderUseCase;
  final AppPreference _appPreference;

  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  OrdersViewModel(this._fetchOrdersUseCase, this._addOrderUseCase,
      this._updateOrderUseCase, this._deleteOrderUseCase, this._appPreference);

  //!----------------------Get Orders---------------------------------------
  Future<void> fetchOrders(BuildContext context) async {
    (await _fetchOrdersUseCase.excute({},
            token: _appPreference.token, userId: _appPreference.userId))
        .fold((failure) {
      showErrorSnackBar(failure.message, context);
    }, (orderItems) {
      if (orderItems == null) {
        _orders = [];
        return;
      }
      _orders = orderItems.reversed.toList();
      notifyListeners();
    });
  }

  //!----------------------Add order---------------------------------------
  void addOrder(List<CartProduct> cartProducts, double total,
      BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final timeStamp = DateTime.now();
    var orderItem = OrderItem(
        id: '', products: cartProducts, amount: total, dateTime: timeStamp);

    (await _addOrderUseCase.excute(
      orderItem,
      token: _appPreference.token,
      userId: _appPreference.userId,
    ))
        .fold((failure) {
      showErrorSnackBar(failure.message, context);
      isLoading = false;
      notifyListeners();
    }, (newOrderId) {
      orderItem.id = newOrderId;
      _orders.insert(0, orderItem);
      context.read<CartViewModel>().clear();
      isLoading = false;
      notifyListeners();
    });
  }

  //!----------------------Update Order---------------------------------------
  void updateOrder(
      String id, OrderItem updatedOrder, BuildContext context) async {
    final orderIndex = orders.indexWhere((order) => order.id == id);
    if (orderIndex < 0) {
      return;
    }

    (await _updateOrderUseCase.excute(
      updatedOrder,
      token: _appPreference.token,
      userId: _appPreference.userId,
    ))
        .fold((failure) {
      showErrorSnackBar(failure.message, context);
    }, (_) {
      _orders[orderIndex] = updatedOrder;
      notifyListeners();
    });
  }

  //!----------------------Delete Order---------------------------------------
  void deleteOrder(String prodId, BuildContext context) async {
    final orderIndex = orders.indexWhere((order) => order.id == prodId);
    if (orderIndex < 0) {
      return;
    }

    (await _deleteOrderUseCase.excute(prodId,
            token: _appPreference.token, userId: _appPreference.userId))
        .fold((failure) {
      showErrorSnackBar(failure.message, context);
    }, (_) {
      _orders.removeAt(orderIndex);
      notifyListeners();
    });
  }
}
