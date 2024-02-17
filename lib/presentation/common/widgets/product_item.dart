import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/app/di.dart';
import '/app/app_prefs.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../domain/models/product.dart';
import '../../cart_screen/viewmodel/viewmodel.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final AppPreference _appPreference = instance();
  ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s10),
      child: GridTile(
        header: null,
        footer: GridTileBar(
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: product.isFavorite
                ? const Icon(Icons.favorite, color: ColorManager.error)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              context.read<HomeViewModel>().toggelFavoriteStatus(
                  product.id!,
                  product.isFavorite,
                  _appPreference.userId,
                  _appPreference.token,
                  context);
            },
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              Provider.of<CartViewModel>(context, listen: false).addItem(
                  product.id!,
                  product.title!,
                  product.price!,
                  product.imageUrl!);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: ColorManager.green,
                  elevation: AppSize.s12,
                  dismissDirection: DismissDirection.horizontal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
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
                  action: SnackBarAction(
                    label: StringsManager.undo,
                    onPressed: () {
                      Provider.of<CartViewModel>(context, listen: false)
                          .reduceQuantity(product.id!);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.productDetailsScreen, arguments: product.id),
          child: Hero(
            tag: product.id!,
            child: FadeInImage(
              placeholder: const AssetImage(ImageAssets.placeholder),
              image: NetworkImage(product.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
