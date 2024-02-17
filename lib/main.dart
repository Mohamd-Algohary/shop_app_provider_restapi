import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '/app/di.dart';
import 'app/app.dart';
import 'presentation/admin_dashboard_screen/edit_product_screen/viewmodel/viewmodel.dart';
import 'presentation/admin_dashboard_screen/viewmodel/viewmodel.dart';
import 'presentation/auth_screen/viewmodel/viewmodel.dart';
import 'presentation/cart_screen/viewmodel/viewmodel.dart';
import 'presentation/orders_screen/viewmodel/viewmodel.dart';
import 'app/themes_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initModule();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) => instance()),
        ChangeNotifierProvider<HomeViewModel>(create: (_) => instance()),
        ChangeNotifierProvider<EditProductViewModel>(create: (_) => instance()),
        ChangeNotifierProvider<OrdersViewModel>(create: (_) => instance()),
        ChangeNotifierProvider<AdminDashboardViewModel>(
            create: (_) => instance()),
        ChangeNotifierProvider<CartViewModel>(create: (_) => instance()),
        ChangeNotifierProvider<ThemesService>(
            create: (_) => instance<ThemesService>()),
      ],
      child: MyApp(),
    ),
  );
}
