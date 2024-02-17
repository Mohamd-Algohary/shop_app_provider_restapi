import 'package:flutter/material.dart';

import '../resources/string_manager.dart';

void showErrorDialog(String message, context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(StringsManager.oops),
      content: Text(
        message,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            StringsManager.ok,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    ),
  );
}

void showErrorSnackBar(String message, context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 4),
    ));
  });
}
