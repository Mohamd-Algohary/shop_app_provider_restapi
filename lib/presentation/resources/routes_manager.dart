import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../admin_dashboard_screen/edit_product_screen/view/edit_product_screen.dart';
import '../admin_dashboard_screen/view/admin_dashboard_screen.dart';
import '/presentation/auth_screen/view/auth_screen.dart';
import '/presentation/cart_screen/view/cart_screen.dart';
import '/presentation/home_screen/view/home_screen.dart';
import '/presentation/orders_screen/view/orders_screen.dart';
import '/presentation/product_details_screen/view/product_details_screen.dart';
import '/presentation/splash_screen/splash_screen.dart';
import 'string_manager.dart';

class Routes {
  static const String splashScreen = '/';
  static const String home = '/home';
  static const String authScreen = '/auth';
  static const String cartScreen = '/cart';
  static const String editProductScreen = '/editProduct';
  static const String ordersScreen = '/orders';
  static const String productDetailsScreen = '/productDetails';
  static const String userProductsScreen = '/userProducts';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.home:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.authScreen:
        initAuthModule();
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case Routes.cartScreen:
        initOrdersModule();
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.editProductScreen:
        initEditProductModule();
        return MaterialPageRoute(
            builder: (_) => const EditProductScreen(), settings: settings);
      case Routes.ordersScreen:
        initOrdersModule();
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.productDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(), settings: settings);
      case Routes.userProductsScreen:
        initUserProductsModule();
        initEditProductModule();
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.noRouteFound),
        ),
        body: const Center(child: Text(StringsManager.noRouteFoundBody)),
      ),
    );
  }
}
