import 'package:animated_refresh/animated_refresh.dart';
import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/purchase_order.dart';
import 'package:tatweer_maximo/screens/purchase_orders_screen/purchase_order_details_screen/purchase_order_details_screen.dart';
import 'package:tatweer_maximo/widgets/custom_progreess_indicator.dart';

class PurchaseOrdersScreen extends StatelessWidget {
  const PurchaseOrdersScreen({
    super.key,
    required this.purchaseOrders,
    required this.loading,
    required this.refreshPurchaseOrders,
    required this.loadPurchaseOrders,
    required this.apiKey,
  });

  final bool loading;
  final List<PurchaseOrder> purchaseOrders;
  final Function refreshPurchaseOrders;
  final Function loadPurchaseOrders;
  final String apiKey;

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedRefresh(
      backgroundColor: Colors.transparent,
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () {
        return refreshPurchaseOrders();
      },
      swipeChild: Icon(
        Icons.refresh,
        color: Theme.of(context).colorScheme.secondary,
      ),
      refreshChild: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CustomProgreessIndicator(),
        ),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        itemCount: purchaseOrders.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => PurchaseOrderDetailsScreen(
                              purchaseOrder: purchaseOrders[index])))
                  .then((onValue) => {loadPurchaseOrders()});
            },
            child: ListTile(
              title: Row(
                children: [
                  Text('${purchaseOrders[index].ponum} - '),
                  Text(purchaseOrders[index].department,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
              subtitle: Text(purchaseOrders[index].description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('EGP', style: TextStyle(fontSize: 10)),
                  Text(
                    purchaseOrders[index].toStringTotalCost,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

    if (loading) {
      content = const Center(child: CustomProgreessIndicator());
    }

    if (purchaseOrders.isEmpty && !loading) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No purchaseOrders Found'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try searching a different product',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
      );
    }
    return content;
  }
}
