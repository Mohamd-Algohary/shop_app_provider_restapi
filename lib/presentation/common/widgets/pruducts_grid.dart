// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/app/di.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/values_manager.dart';
import '../../../domain/models/product.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorite;
  List<Product> products = [];
  ProductsGrid(this.showFavorite, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    products = showFavorite
        ? context.read<HomeViewModel>().favoriteItems
        : context.read<HomeViewModel>().items;

    return GridView.builder(
      padding: const EdgeInsets.all(AppPadding.p10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: AppSize.s10,
          crossAxisSpacing: AppSize.s10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: instance<HomeViewModel>()..items,
        child: ProductItem(products[index]),
      ),
    );
  }
}
