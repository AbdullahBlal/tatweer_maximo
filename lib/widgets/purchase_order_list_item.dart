import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/purchase_order.dart';
import '../reusable functions/full_text_content.dart';

class PurchaseOrderListItem extends StatelessWidget {
  const PurchaseOrderListItem(this.purchaseOrder, {super.key});

  final PurchaseOrder purchaseOrder;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
             Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PO # ${purchaseOrder.ponum}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    SizedBox(
                        width: 150, child: Text(purchaseOrder.description)),
                  ],
                ),
                OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    elevation: 5,
                    shadowColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: InkWell(
                    onTap: () {
                      showFullText(purchaseOrder.statusDescription, context);
                    },
                    child: Text(
                      purchaseOrder.status,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(purchaseOrder.department,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.outlineVariant)),
                    Text(purchaseOrder.departmentDescription)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('EGP', style: TextStyle(fontSize: 15)),
                    Text(
                      purchaseOrder.toStringTotalCost,
                      style: const TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
