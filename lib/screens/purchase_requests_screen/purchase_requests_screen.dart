import 'package:animated_refresh/animated_refresh.dart';
import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/purchase_request.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/purchase_request_details_screen.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';

class PurchaseRequestsScreen extends StatelessWidget {
  const PurchaseRequestsScreen({
    super.key,
    required this.purchaseRequests,
    required this.loading,
    required this.refreshPurchaseRequests,
    required this.loadPurchaseRequests,
    required this.apiKey,
  });

  final bool loading;
  final List<PurchaseRequest> purchaseRequests;
  final Function refreshPurchaseRequests;
  final Function loadPurchaseRequests;
  final String apiKey;

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedRefresh(
      backgroundColor: Colors.transparent,
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () {
        return refreshPurchaseRequests();
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
        itemCount: purchaseRequests.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => PurchaseRequestDetailsScreen(
                              purchaseRequest: purchaseRequests[index])))
                  .then((onValue) => {loadPurchaseRequests()});
            },
            child: ListTile(
              title: Row(
                children: [
                  Text('${purchaseRequests[index].prnum} - '),
                  Text(purchaseRequests[index].department,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
              subtitle: Text(purchaseRequests[index].description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('EGP', style: TextStyle(fontSize: 10)),
                  Text(
                    purchaseRequests[index].toStringTotalCost,
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

    if (purchaseRequests.isEmpty && !loading) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No purchase Requests Found'),
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
