import 'package:flutter/material.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';

class CustomRectangleButton extends StatelessWidget {
  const CustomRectangleButton(
      {super.key,
      required this.onClick,
      required this.text,
      required this.theme,
      required this.loading,
      required this.disabled});
  final String text;
  final String theme;
  final bool loading;
  final Function onClick;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: disabled
          ? null
          : () {
              onClick();
            },
      child: loading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: Center(child: CustomProgreessIndicator()),
            )
          : Text(
              text,
              style: disabled
                  ? TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    )
                  : TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
            ),
    );
  }
}
