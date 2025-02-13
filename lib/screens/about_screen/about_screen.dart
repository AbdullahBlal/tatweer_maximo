import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "About Us",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home-background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Since its inception in 2014, Tatweer Misr has been a vital catalyst for change,\n"
                    "delivering incomparable value through exemplary projects that master all facets of development.\n\n"
                    "Boasting a wealth of industrial and technical expertise, Tatweer Misr has been offering an innovative outlook "
                    "on integrated living to strongly emerge as a leading real-estate developer in Egypt.\n\n"
                    "Fulfilling the rising demand for mixed-use projects that enrich the life of its communities, "
                    "Tatweer Misr remains committed to excellence in design, innovation, and sustainability.\n\n"
                    "Its unique edge lies in a solution-oriented approach spanning quality construction, "
                    "landmark architecture, unique landscaping, and an abundance of lifestyle amenities, all aimed at "
                    "fostering the growth and well-being of its residents.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.6, // Enhanced readability
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
