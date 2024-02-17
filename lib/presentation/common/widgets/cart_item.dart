import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../cart_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../domain/models/cart.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  final String prodId;
  const CartItem(
    this.cartProduct,
    this.prodId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(prodId),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: AppPadding.p20),
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m15, vertical: AppMargin.m4),
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: ColorManager.white,
          size: AppSize.s40,
        ),
      ),
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(StringsManager.areYouSure),
            content: const Text(StringsManager.removeProduct),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    StringsManager.delete,
                    style: TextStyle(color: ColorManager.error),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  StringsManager.cancel,
                ),
              )
            ],
          );
        },
      ),
      onDismissed: (_) {
        Provider.of<CartViewModel>(context, listen: false).removeItem(prodId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m10, vertical: AppMargin.m4),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              Flexible(
                child: ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(AppMargin.m10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(cartProduct.imageUrl!)),
                      shape: BoxShape.circle,
                    ),
                    width: AppSize.s40,
                    height: AppSize.s40,
                  ),
                  title: Text(cartProduct.title!,
                      style: Theme.of(context).textTheme.displayMedium),
                  subtitle: Text(
                      "${StringsManager.total} \$${(cartProduct.price! * cartProduct.quantity)}",
                      style: Theme.of(context).textTheme.displaySmall),
                  trailing: Text("${cartProduct.quantity} X"),
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CartViewModel>(context, listen: false)
                      .reduceQuantity(prodId);
                },
                icon: const Icon(Icons.remove_circle),
                iconSize: AppSize.s20,
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CartViewModel>(context, listen: false).addItem(
                      prodId,
                      cartProduct.title!,
                      cartProduct.price!,
                      cartProduct.imageUrl!);
                },
                icon: const Icon(Icons.add_circle),
                iconSize: AppSize.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
