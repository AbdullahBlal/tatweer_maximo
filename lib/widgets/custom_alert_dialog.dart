import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return const Text('alert dialog');
  }
}