import 'package:flutter/material.dart';
import 'package:tatweer_maximo/main.dart';

void showSnackbar(String message) {
  rootScaffoldMessengerKey.currentState!.clearSnackBars();
  rootScaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ),
  );
}
