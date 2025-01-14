import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/screens/login_screen/login_screen.dart';
import 'package:tatweer_approval/screens/splash_screen/splash_screen.dart';
import 'package:tatweer_approval/screens/tabs_screen/tabs_screen.dart';
import 'package:local_auth/local_auth.dart';
import '../../providers/user_provider.dart';

late StreamController<String> authStreamController;

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends ConsumerState<MainScreen>
    with TickerProviderStateMixin {
  late final LocalAuthentication auth;
  String apiKey = '';

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print(availableBiometrics);

    if (!mounted) {
      return;
    }
  }

  Future<void> authenticate() async {
    // Get available biometrics
    // getAvailableBiometrics();
    try {
      bool authenticate = await auth.authenticate(
          localizedReason: "Authenticate to start using the application.",
          options: const AuthenticationOptions(
            stickyAuth: true,
            // biometricOnly: true (allow only biometric authentication, not pattern, PIN,...)
            // biometricOnly: true
          ));
      if (authenticate) {
        authStreamController.sink.add(apiKey);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    auth = LocalAuthentication();
    // Create a stream controller.
    authStreamController = StreamController<String>.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await _checkLoggedIn();
    super.didChangeDependencies();
  }

  Future<void> _checkLoggedIn() async {
    await ref.read(userProvider.notifier).checkApiKeyExistance();
    apiKey = ref.read(userProvider.notifier).getApiKey();
    print(apiKey);
    await Future.delayed(Duration(milliseconds: 2000));
    if (apiKey != '') {
      auth.isDeviceSupported().then((bool isSupported) {
        if (isSupported) {
          authenticate();
        } else {
          authStreamController.sink.add(apiKey);
        }
      });
    } else {
      authStreamController.sink.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Display a splash screen when waiting for apikey.
          }
          if (snapshot.data == '') {
            return const LoginScreen(); // Display login screen when apikey is not available.
          }
          return const TabsScreen(); // Display tabs screen if apikey is available.
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return const SplashScreen();
  // }
}
