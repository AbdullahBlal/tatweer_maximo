import 'package:flutter/material.dart';
import 'package:tatweer_approval/reusable%20functions/number_formatter.dart';

class HomeScreenCounter extends StatelessWidget {
  const HomeScreenCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(5)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
          border: Border.all(color: Theme.of(context).colorScheme.primary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(5),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.local_activity,
                      color: Color.fromARGB(255, 107, 226, 142),
                    ),
                  ),
                  const SizedBox(width:10),
                  Text(
                    "Complete Purchase Orders",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Amount:',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary)),
                  Text(displayNumberFormatter.format(2156151120),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
