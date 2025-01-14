import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:tatweer_approval/models/workorder_material.dart';

class WoMaterials extends StatelessWidget {
  const WoMaterials({super.key, required this.woMaterials});

  final List<WorkorderMaterial> woMaterials;

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
        for (WorkorderMaterial woMaterial in woMaterials)
          AccordionSection(
            contentVerticalPadding: 20,
            header: Text(woMaterial.description, style: headerStyle),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Storeroom:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            woMaterial.storeroom,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity:',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                        Text(woMaterial.toStringQuantity),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Unit Cost: ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            Text(
                              woMaterial.toStringUnitCost,
                              softWrap: true,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Line Cost: ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            Text(woMaterial.toStringLineCost),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Line Price: ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            Text(woMaterial.toStringLinePrice),
                          ],
                        ),
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
