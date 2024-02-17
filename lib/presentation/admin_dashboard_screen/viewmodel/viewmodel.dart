import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../home_screen/viewmodel/viewmodel.dart';
import '/presentation/common/base_viewmodel.dart';
import '/app/app_prefs.dart';
import '/domain/usecase/delete_product_usecase.dart';
import '../../common/error_message.dart';

class AdminDashboardViewModel extends BaseViewModel {
  final DeleteProductUseCase _deleteProductUseCase;
  final AppPreference _appPreference;

  AdminDashboardViewModel(this._deleteProductUseCase, this._appPreference);

  //!----------------------Delete Product---------------------------------------
  void deleteProduct(String prodId, BuildContext context) async {
    final productIndex = context
        .read<HomeViewModel>()
        .items
        .indexWhere((product) => product.id == prodId);
    if (productIndex < 0) {
      return;
    }
    (await _deleteProductUseCase.excute(prodId, token: _appPreference.token))
        .fold((failure) {
      showErrorSnackBar(failure.message, context);
    }, (_) {
      context.read<HomeViewModel>().items.removeAt(productIndex);
      notifyListeners();
    });
  }
}
