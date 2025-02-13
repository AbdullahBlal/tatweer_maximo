import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tatweer_maximo/models/main_card.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard(
      {super.key, required this.cardContent, required this.navigateToPage});

  final MainCard cardContent;
  final Function navigateToPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(cardContent.index);
      },
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -20, end: -5),
        badgeStyle: badges.BadgeStyle(
            padding: const EdgeInsets.all(12),
            badgeColor: Theme.of(context).colorScheme.secondary),
        badgeContent: Text(cardContent.recordsTotal),
        child: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
              border: Border.all(color: Theme.of(context).colorScheme.primary)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Image.asset(cardContent.iconPath, width: 60,),
                    const SizedBox(width: 10,),
                    SizedBox(
                      child: Text(
                      cardContent.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
