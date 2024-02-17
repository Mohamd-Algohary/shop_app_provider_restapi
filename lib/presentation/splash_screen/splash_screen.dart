import 'package:flutter/material.dart';

import '/app/app_prefs.dart';
import '/app/di.dart';
import '/presentation/resources/constants_manager.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/string_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppPreference _appPreference = instance();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: AppConstants.splashTime), () {
      if (_appPreference.isUserLoggedin()) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.authScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        StringsManager.loading,
        style: Theme.of(context).textTheme.displayLarge,
      )),
    );
  }
}
