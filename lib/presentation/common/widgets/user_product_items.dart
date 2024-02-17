import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../admin_dashboard_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../domain/models/product.dart';

class UserProductItems extends StatelessWidget {
  final Product product;
  const UserProductItems(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl!),
        radius: AppSize.s40,
      ),
      title: Text(
        product.title!,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      trailing: SizedBox(
        width: AppSize.s100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(Routes.editProductScreen, arguments: product.id),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<AdminDashboardViewModel>(context, listen: false)
                    .deleteProduct(product.id!, context);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
