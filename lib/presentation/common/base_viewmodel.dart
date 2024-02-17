import 'package:flutter/material.dart';

abstract class BaseViewModel with ChangeNotifier {
  bool isLoading = false;

  void onInit(BuildContext context) {}
  void onDispose() {}
}
