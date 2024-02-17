import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/cart.dart';
import '../../common/base_viewmodel.dart';

class CartViewModel extends BaseViewModel {
  final Box<CartProduct> _box;
  CartViewModel(this._box);

  final Map<String, CartProduct> _cartItems = {};
  Map<String, CartProduct> get cartItems => {..._cartItems};

  int get itemCount => _cartItems.length;

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity;
    });
    return total;
  }

  @override
  void onInit(BuildContext context) {
    if (_box.isEmpty) {
      return;
    }
    for (var key in _box.keys) {
      _cartItems[key] = _box.get(key)!;
    }
  }

//!----------------------Add Product to cart------------------------------------
  void addItem(String prodId, String title, double price, String imageUrl) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems[prodId]!.quantity++;
      _box.put(prodId, _cartItems[prodId]!);
    } else {
      _cartItems[prodId] = CartProduct(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
          imageUrl: imageUrl);
      _box.put(prodId, _cartItems[prodId]!);
    }
    notifyListeners();
  }

//!----------------------Remove Product Form Cart-------------------------------
  void removeItem(String prodId) {
    _cartItems.remove(prodId);
    _box.delete(prodId);
    notifyListeners();
  }

//!----------------------Reduce Quantity From Cart---------------------------------------
  void reduceQuantity(String prodId) {
    if (_cartItems.containsKey(prodId)) {
      if (_cartItems[prodId]!.quantity > 1) {
        _cartItems[prodId]!.quantity--;
        _box.put(prodId, _cartItems[prodId]!);
      } else {
        _cartItems.remove(prodId);
        _box.delete(prodId);
      }
      notifyListeners();
    } else {
      return;
    }
  }

//!----------------------Clear Cart---------------------------------------
  void clear() {
    _cartItems.clear();
    _box.clear();
    notifyListeners();
  }
}
