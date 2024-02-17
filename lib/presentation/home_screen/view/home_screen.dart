import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/string_manager.dart';
import '../../cart_screen/viewmodel/viewmodel.dart';
import '../../resources/constants_manager.dart';
import '../../resources/font_manager.dart';
import '../../common/widgets/app_drawer.dart';
import '../../common/widgets/pruducts_grid.dart';

enum FilterOption { Favorite, All }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().getProducts(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeViewModel>().isLoading = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.maShop),
        actions: [
          PopupMenuButton<FilterOption>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return const [
                PopupMenuItem(
                  value: FilterOption.Favorite,
                  child: Text(StringsManager.onlyFavorites),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: FilterOption.All,
                  child: Text(StringsManager.showAll),
                ),
              ];
            },
            onSelected: (selectedValue) {
              if (selectedValue == FilterOption.Favorite) {
                context.read<HomeViewModel>().showFavorite(true);
              } else {
                context.read<HomeViewModel>().showFavorite(false);
              }
            },
          ),
          Consumer<CartViewModel>(
            child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.cartScreen),
                icon: const Icon(Icons.shopping_cart)),
            builder: (ctx, vm, iconButton) {
              vm.onInit(ctx);
              return Badge.count(
                count: vm.itemCount,
                textStyle: const TextStyle(fontSize: FontSize.s14),
                offset: const Offset(
                    -AppConstants.badgeOffset, AppConstants.badgeOffset),
                child: iconButton,
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          return RefreshIndicator(
            color: ColorManager.primary,
            backgroundColor: ColorManager.grey,
            onRefresh: (() => vm.getProducts(context)),
            child: vm.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : vm.items.isEmpty
                    ? Center(
                        child: Text(
                          StringsManager.noProductYet,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      )
                    : ProductsGrid(vm.showOnlyfavorite),
          );
        },
      ),
      drawer: Appdrawer(),
    );
  }
}
