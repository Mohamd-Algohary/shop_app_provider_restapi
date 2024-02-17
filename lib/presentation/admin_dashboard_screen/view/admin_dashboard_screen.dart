import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../edit_product_screen/viewmodel/viewmodel.dart';
import '../viewmodel/viewmodel.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../common/widgets/app_drawer.dart';
import '../../common/widgets/user_product_items.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(StringsManager.yourProducts),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(Routes.editProductScreen, arguments: ''),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer3<HomeViewModel, EditProductViewModel,
          AdminDashboardViewModel>(
        builder: (BuildContext ctx, homeVM, editProdVM, userProdVM, _) {
          return RefreshIndicator(
            onRefresh: () => homeVM.getProducts(ctx),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: homeVM.items.isEmpty
                  ? Center(
                      child: Text(
                        StringsManager.doNotAddProduct,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  : ListView.separated(
                      itemCount: homeVM.items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (_, index) =>
                          UserProductItems(homeVM.items[index]),
                    ),
            ),
          );
        },
      ),
      drawer: Appdrawer(),
    );
  }
}
