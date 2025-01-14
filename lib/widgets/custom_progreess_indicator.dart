import 'package:flutter/material.dart';

class CustomProgreessIndicator extends StatelessWidget {
  const CustomProgreessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
