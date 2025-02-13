import 'package:flutter/material.dart';
import 'package:tatweer_maximo/screens/login_screen/login_screen.dart';
import 'package:tatweer_maximo/screens/project_screen/project_index_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});
  @override
  State<InitialScreen> createState() => _SigninOrSignUpScreenState();
}

class _SigninOrSignUpScreenState extends State<InitialScreen> {
  bool screenIsSignIn = true;
  void toggleScreen() {
    setState(() {
      screenIsSignIn = !screenIsSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget toggledScreen = screenIsSignIn
        ? ProjectIndexScreen(toggleScreen: toggleScreen)
        : LoginScreen(toggleScreen: toggleScreen);

    return toggledScreen;
  }
}
