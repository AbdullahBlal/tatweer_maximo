import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/purchase_request_line.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class PrLines extends StatelessWidget {
  const PrLines({super.key, required this.prLines});

  final List<PurchaseRequestLine> prLines;

  @override
  Widget build(BuildContext context) {
    final headerStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14);
    final leftHeaderStyle = TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 15,
        fontWeight: FontWeight.bold);
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
        for (PurchaseRequestLine prLine in prLines)
          AccordionSection(
            contentVerticalPadding: 20,
            leftIcon: Text('${prLine.prLineNum}', style: leftHeaderStyle),
            header: Text(prLine.description, style: headerStyle),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reported By:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            prLine.requestedByName,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Line Type:',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                        ),
                        Text(prLine.lineType),
                      ],
                    ),
                  ],
                ),
                prLine.lineType == 'ITEM'
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Storeroom:',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  prLine.storeloc,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cost Center:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            prLine.glAccount,
                          ),
                        ),
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
                              prLine.toStringUnitCost,
                              softWrap: true,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'VAT: ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            Text(prLine.toStringVat),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Quantity: ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            Text(prLine.toStringQuantity),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('EGP', style: TextStyle(fontSize: 15)),
                        Text(
                          prLine.toStringLoadedCost,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }
}
