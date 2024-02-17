// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../cart_screen/viewmodel/viewmodel.dart';
import '../../../domain/models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  late final String prodId;
  late final Product prod;
  ProductDetailsScreen({super.key});

  void _bind(BuildContext ctx) {
    prodId = ModalRoute.of(ctx)!.settings.arguments as String;
    prod = Provider.of<HomeViewModel>(ctx, listen: false).findById(prodId);
  }

  @override
  Widget build(BuildContext context) {
    _bind(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: AppSize.s300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(prod.title!),
            background: Hero(
              tag: prod.id!,
              child: Image.network(prod.imageUrl!),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: AppSize.s15),
              Text(
                "\$${prod.price}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppSize.s15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                width: double.infinity,
                child: Text(
                  prod.description!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: AppSize.s25),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(AppMargin.m10),
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  width: double.infinity,
                  height: AppSize.s60,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.shopping_cart),
                        Text(
                          StringsManager.addToCart,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    onPressed: () {
                      context.read<CartViewModel>().addItem(
                          prod.id!, prod.title!, prod.price!, prod.imageUrl!);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: ColorManager.green,
                          elevation: AppSize.s12,
                          dismissDirection: DismissDirection.horizontal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          action: SnackBarAction(
                            label: StringsManager.undo,
                            onPressed: () {
                              Provider.of<CartViewModel>(context, listen: false)
                                  .reduceQuantity(prod.id!);
                            },
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline_outlined),
                              const SizedBox(width: AppSize.s15),
                              Text(
                                StringsManager.itemAdded,
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
