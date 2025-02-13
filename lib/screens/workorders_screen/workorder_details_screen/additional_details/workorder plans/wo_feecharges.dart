import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:tatweer_maximo/models/workorder_feecharge.dart';

class WoFeeCharges extends StatelessWidget {
  const WoFeeCharges({super.key, required this.woFeeCharges});

  final List<WorkorderFeeCharge> woFeeCharges;

  @override
  Widget build(BuildContext context) {
    final headerStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14);
    return Accordion(
      headerBorderColor: Theme.of(context).colorScheme.primary,
      headerBorderColorOpened: Theme.of(context).colorScheme.secondary,
      headerBorderWidth: 1,
      headerBackgroundColor: Theme.of(context).colorScheme.tertiary,
      contentBackgroundColor: Theme.of(context).colorScheme.tertiary,
      contentBorderColor: Theme.of(context).colorScheme.secondary,
      contentBorderWidth: 2,
      contentHorizontalPadding: 20,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      rightIcon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black54,
        size: 20,
      ),
      children: [
        for (WorkorderFeeCharge woFeeCharge in woFeeCharges)
          AccordionSection(
            contentVerticalPadding: 20,
            header: Text(woFeeCharge.description, style: headerStyle),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type:',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                        Text(woFeeCharge.type),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Line Price:',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                        Text(woFeeCharge.toStringLinePrice),
                      ],
                    ),
                  ],
                ),
                
              ],
            ),
          ),
      ],
    );
  }
}
