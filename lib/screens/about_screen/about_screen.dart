import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/home-background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Column(
        children: [
           Row(children: []),
           SizedBox(height: 50,)
        ],
      )
    );
  }
}