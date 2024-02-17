import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/app/themes_services.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  const MyApp._internal();
  static const _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: getApplicationDarkTheme(),
      theme: getApplicationLightTheme(),
      themeMode: context.watch<ThemesService>().themeMode,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}
