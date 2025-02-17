import 'package:flutter/material.dart';
import 'package:tatweer_maximo/screens/login_screen/login_screen.dart';
import 'package:tatweer_maximo/screens/signup_screen/signup_screen.dart';
import 'package:tatweer_maximo/screens/project_screen/project_index_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String screenState = "projects"; // Default screen is Login

  void toggleScreen(String screen) {
    setState(() {
      screenState = screen; // Switch to the selected screen
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget toggledScreen;

    switch (screenState) {
      case "signup":
        toggledScreen = SignupScreen(toggleScreen: toggleScreen);
        break;
      case "login":
        toggledScreen = LoginScreen(toggleScreen: toggleScreen);
        break;
      default:
        toggledScreen = ProjectIndexScreen(toggleScreen: toggleScreen);
    }

    return toggledScreen;
  }
}
