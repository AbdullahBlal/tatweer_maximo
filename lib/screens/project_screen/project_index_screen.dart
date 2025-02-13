import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/project.dart';
import 'package:tatweer_approval/screens/project_screen/project_details_screen.dart';
import 'package:tatweer_approval/screens/login_screen/login_screen.dart'; // Import Login Screen

class ProjectIndexScreen extends StatelessWidget {
  const ProjectIndexScreen({super.key, required this.toggleScreen});

  final Function toggleScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep background black
      appBar: AppBar(
        backgroundColor: Colors.black, // Keep AppBar black
        elevation: 0,
        scrolledUnderElevation: 0, // Prevents color change when scrolling
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white), // Ensures back button is white
        title: Column(
          children: [
            SizedBox(
              height: 50, // Keep size relative to AppBar
              width: 200,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  'assets/images/logo-white2.png',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LoginScreen()),
              //   (route) => false, // Removes all previous routes
              // );

              toggleScreen();
            },
            icon: const Icon(Icons.login, color: Colors.white, size: 18),
            label: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tatweerProjects.length,
        itemBuilder: (context, index) {
          final project = tatweerProjects[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailsScreen(project: project),
                ),
              );
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Card(
                color: Colors.black, // Keep card background black
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        project.imagePath,
                        width: double.infinity,
                        height: null,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          project.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
