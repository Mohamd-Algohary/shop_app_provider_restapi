import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/app/themes_services.dart';
import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../resources/routes_manager.dart';

class Appdrawer extends StatelessWidget {
  final AppPreference _appPreference = instance();
  Appdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            title: Text(
              StringsManager.maShop,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.shop,
              size: AppSize.s22,
            ),
            title: Text(StringsManager.shop,
                style: Theme.of(context).textTheme.displayMedium),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.home),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
              size: AppSize.s22,
            ),
            title: Text(StringsManager.orders,
                style: Theme.of(context).textTheme.displayMedium),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.ordersScreen),
          ),
          const Divider(),
          if (_appPreference.isAdmin)
            ListTile(
              leading: const Icon(
                Icons.edit,
                size: AppSize.s22,
              ),
              title: Text(StringsManager.manageProducts,
                  style: Theme.of(context).textTheme.displayMedium),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(Routes.userProductsScreen),
            ),
          if (_appPreference.isAdmin) const Divider(),
          ListTile(
              leading: Icon(
                context.read<ThemesService>().getCurrentTheme() ==
                        ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: AppSize.s22,
              ),
              title: Text(StringsManager.changeTheme,
                  style: Theme.of(context).textTheme.displayMedium),
              onTap: () {
                Navigator.of(context).pop();
                context.read<ThemesService>().changeTheme();
              }),
          const Divider(),
          ListTile(
              leading: const Icon(
                Icons.logout,
                size: AppSize.s22,
              ),
              title: Text(StringsManager.logout,
                  style: Theme.of(context).textTheme.displayMedium),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Routes.authScreen);
                _appPreference.logout();
              })
        ],
      ),
    );
  }
}
