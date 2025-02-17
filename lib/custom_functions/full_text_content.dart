import 'package:flutter/material.dart';

void showFullText(String fullText, BuildContext context) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Center(
            child: Icon(
              size: 50,
              Icons.more_horiz_rounded,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10,),
              Text(fullText)
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primary,),
                  foregroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.tertiary,)),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }