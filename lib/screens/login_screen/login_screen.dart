import 'package:flutter/material.dart';
import 'package:tatweer_approval/screens/project_screen/project_index_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_form.dart';
import 'package:tatweer_approval/screens/main_screen/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key, required this.toggleScreen});
  final Function toggleScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void logIn(BuildContext context, String username, String password,
        Function disableLoginSpinner) async {
      final apikey = await ref
          .read(userProvider.notifier)
          .logIn({"username": username, "password": password});
      if (apikey == '') {
        disableLoginSpinner();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: const Text('Username or Password incorrect'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      } else if (apikey == 'EMPTYSG') {
        disableLoginSpinner();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            content: const Text(
                'You have no assigned start centers, please contact system administrator'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      } else {
        authStreamController.sink.add(apikey);
        disableLoginSpinner();
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/login_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Projects Button (Top-Left Corner)
            Positioned(
              top: 10, // Adjust for better visibility
              left: 10,
              child: SafeArea(
                child: TextButton.icon(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const ProjectIndexScreen()),
                    //   (route) => false, // Removes all previous routes
                    // );
                    toggleScreen();
                  },
                  icon: const Icon(Icons.home, color: Colors.black, size: 18),
                  label: const Text(
                    "Projects",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            // Login Form Container
            Center(
              child: Container(
                width: 350,
                height: 400,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/tatweer_misr_logo_dark.svg',
                      width: 250,
                    ),
                    const SizedBox(height: 20),
                    LoginForm(
                      onLogIn: (String username, String password,
                          Function disableLoginSpinner) {
                        logIn(context, username, password, disableLoginSpinner);
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Powered By ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Image.asset(
                          'assets/images/megasoft_copyrights_logo_dark.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
