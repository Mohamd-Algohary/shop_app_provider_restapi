import 'package:flutter/material.dart';

import '/presentation/common/base_viewmodel.dart';
import '/app/app_prefs.dart';
import '/domain/usecase/get_products_usecase.dart';
import '/domain/usecase/get_user_fav_usecase.dart';
import '/domain/usecase/toggel_fav_status_usecase.dart';
import '../../../domain/models/product.dart';
import '../../common/error_message.dart';

class HomeViewModel extends BaseViewModel {
  final GetProductsUseCase _getProductsUseCase;
  final GetUserFavUseCase _getUserFavUseCase;
  final ToggelFavStatusUseCase _toggelFavStatusUseCase;
  final AppPreference _appPreference;

  bool showOnlyfavorite = false;

  List<Product> items = [];

  List<Product> get favoriteItems {
    return [...items.where((item) => item.isFavorite)];
  }

  Product findById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  HomeViewModel(
    this._getProductsUseCase,
    this._getUserFavUseCase,
    this._toggelFavStatusUseCase,
    this._appPreference,
  );

  //!----------------------Get Products---------------------------------------
  Future<void> getProducts(BuildContext context,
      [bool isFilterByUser = false]) async {
    final filter = isFilterByUser
        ? 'orderBy="creatorId"&equalTo="${_appPreference.userId}"'
        : '';
    items.clear();
    (await _getProductsUseCase.excute(filter, token: _appPreference.token))
        .fold((failure) {
      showErrorDialog(failure.message, context);
      isLoading = false;
      notifyListeners();
    }, (products) async {
      (await _getUserFavUseCase.excute({},
              token: _appPreference.token, userId: _appPreference.userId))
          .fold((failure) {
        showErrorDialog(failure.message, context);
        isLoading = false;
        notifyListeners();
      }, (favData) {
        if (favData.isEmpty) {
          items = products;
        } else {
          final List<Product> loadedProducts = [];
          for (var prod in products) {
            prod.isFavorite = favData[prod.id] ?? false;
            loadedProducts.add(prod);
          }
          items = loadedProducts;
        }
      });
      isLoading = false;
      notifyListeners();
    });
  }

  //!----------------------Set Favorite-----------------------------------------
  void toggelFavoriteStatus(String productId, bool isFav, String? userID,
      String? token, BuildContext context) async {
    var index = items.indexWhere((prod) => prod.id == productId);
    items[index].isFavorite = !isFav;
    notifyListeners();
    (await _toggelFavStatusUseCase.excute(!isFav,
            token: _appPreference.token,
            userId: _appPreference.userId,
            prodId: productId))
        .fold((failure) {
      showErrorDialog(failure.message, context);
      items[index].isFavorite = !isFav;
      notifyListeners();
    }, (_) {});
  }

  void showFavorite(bool showFav) {
    showOnlyfavorite = showFav;
    notifyListeners();
  }
}
