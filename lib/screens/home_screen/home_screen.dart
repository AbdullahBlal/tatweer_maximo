import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_maximo/models/main_card.dart';
import 'package:tatweer_maximo/screens/home_screen/home_screen_card.dart';
// import 'package:tatweer_maximo/screens/home_screen/home_screen_counter.dart';
import 'package:tatweer_maximo/widgets/custom_progreess_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.navigateToPage,
      required this.getTotalRecords,
      required this.loading,
      required this.cardsContent,
      required this.apiKey});

  final List<MainCard> cardsContent;
  final Function getTotalRecords;
  final Function navigateToPage;
  final bool loading;
  final String apiKey;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/home-background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          for (MainCard cardContent in cardsContent)
            cardContent.recordsTotal != null
                ? Column(
                    children: [
                      HomeScreenCard(
                          cardContent: cardContent,
                          navigateToPage: navigateToPage),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          // const HomeScreenCounter(),
          // const SizedBox(height: 10,),
          // const HomeScreenCounter()
        ],
      ),
    );

    if (loading) {
      content = const Center(child: CustomProgreessIndicator());
    }

    return content;
  }
}
