import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../domain/models/product.dart';
import '../../../../domain/usecase/add_product_usecase.dart';
import '../../../common/error_message.dart';
import '../../../home_screen/viewmodel/viewmodel.dart';
import '/presentation/common/base_viewmodel.dart';
import '/app/app_prefs.dart';
import '/domain/usecase/update_product_usecase.dart';

class EditProductViewModel extends BaseViewModel {
  final AddProductUseCase _addProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final AppPreference _appPreference;

  bool isImageUrlValid = false;
  String prodId = '';
  late Product newProduct;
  late Map<String, String> initialValues = {};
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();
  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditProductViewModel(
      this._addProductUseCase, this._updateProductUseCase, this._appPreference);

  @override
  void onInit(BuildContext context) {
    imageUrlFocusNode.addListener(updateImageUrl);
    if (prodId.isEmpty) {
      newProduct =
          Product(id: '', title: '', description: '', imageUrl: '', price: 0);
      initialValues = {
        'title': '',
        'description': '',
        'imageUrl': '',
        'price': ''
      };
      imageUrlController.text = '';
    } else {
      newProduct = context.read<HomeViewModel>().findById(prodId);
      initialValues = {
        'title': newProduct.title!,
        'description': newProduct.description!,
        'imageUrl': '',
        'price': newProduct.price.toString()
      };
      imageUrlController.text = newProduct.imageUrl!;
    }
  }

  @override
  void onDispose() {
    imageUrlFocusNode.removeListener(updateImageUrl);
    imageUrlFocusNode.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlController.dispose();
  }

  //!----------------------Add Product---------------------------------------
  void addProduct(Product product, BuildContext context) async {
    (await _addProductUseCase.excute(product,
            token: _appPreference.token, userId: _appPreference.userId))
        .fold((failure) {
      showErrorDialog(failure.message, context);
      Navigator.of(context).pop();
    }, (newProductId) {
      product.id = newProductId;
      context.read<HomeViewModel>().items.add(product);
      Navigator.of(context).pop();
      notifyListeners();
    });
  }

  //!----------------------Update Product---------------------------------------
  void updateProduct(
      String prodId, Product updatedproduct, BuildContext context) async {
    final productIndex = context
        .read<HomeViewModel>()
        .items
        .indexWhere((product) => product.id == prodId);
    if (productIndex < 0) {
      return;
    } else {
      (await _updateProductUseCase.excute(updatedproduct,
              token: _appPreference.token, prodId: prodId))
          .fold((failure) {
        showErrorDialog(failure.message, context);
        Navigator.of(context).pop();
      }, (_) {
        context.read<HomeViewModel>().items[productIndex] = updatedproduct;
        Navigator.of(context).pop();
        notifyListeners();
      });
    }
  }

  void updateImageUrl() {
    if (imageUrlController.text.isNotEmpty && !imageUrlFocusNode.hasFocus) {
      if ((!imageUrlController.text.startsWith('http') ||
              !imageUrlController.text.startsWith('https')) &&
          (!imageUrlController.text.endsWith('png') ||
              !imageUrlController.text.endsWith('jpg') ||
              !imageUrlController.text.endsWith('jpeg'))) {
      } else {
        notifyListeners();
      }
    }
  }

  void saveForm(context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading = true;
      if (newProduct.id!.isNotEmpty) {
        updateProduct(newProduct.id!, newProduct, context);
      } else {
        addProduct(newProduct, context);
      }
    } else {
      return;
    }
    isLoading = false;
    notifyListeners();
  }
}
