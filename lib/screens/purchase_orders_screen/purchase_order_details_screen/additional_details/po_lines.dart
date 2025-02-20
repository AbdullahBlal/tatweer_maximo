import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/purchase_order_line.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class PoLines extends StatelessWidget {
  const PoLines({super.key, required this.poLines, required this.currencyCode});

  final String currencyCode;
  final List<PurchaseOrderLine> poLines;

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
        for (PurchaseOrderLine poLine in poLines)
          AccordionSection(
            contentVerticalPadding: 20,
            leftIcon: Text('${poLine.polinenum}', style: leftHeaderStyle),
            header: Text(poLine.description, style: headerStyle),
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
                            poLine.requestedByName,
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
                        Text(poLine.lineType),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                poLine.lineType == 'ITEM'
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
                                  poLine.storeloc,
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
                            poLine.glAccount,
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
                              poLine.toStringUnitCost,
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
                            Text(poLine.toStringVat),
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
                            Text(poLine.toStringQuantity),
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
                        Text(currencyCode, style: const TextStyle(fontSize: 15)),
                        poLine.isDiscountApplied?Text(
                          poLine.toStringOriginallineCost,
                          style: TextStyle(fontSize: 15,decoration: TextDecoration.lineThrough, decorationColor: Theme.of(context).colorScheme.secondary, decorationThickness: 4),
                        ):const SizedBox.shrink(),
                        Text(
                          poLine.toStringLoadedCost,
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
