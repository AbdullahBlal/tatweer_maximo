import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_maximo/models/doclink.dart';
import 'package:tatweer_maximo/models/purchase_order.dart';
import 'package:tatweer_maximo/providers/purchase_order_provider.dart';
import 'package:tatweer_maximo/providers/user_provider.dart';
import 'package:tatweer_maximo/screens/purchase_orders_screen/purchase_order_details_screen/additional_details/po_additional_details_card.dart';
import 'package:tatweer_maximo/screens/purchase_orders_screen/purchase_order_details_screen/po_main_details_card.dart';
import 'package:tatweer_maximo/widgets/custom_progreess_indicator.dart';

class PurchaseOrderDetailsScreen extends ConsumerStatefulWidget {
  const PurchaseOrderDetailsScreen({super.key, required this.purchaseOrder});

  final PurchaseOrder purchaseOrder;

  @override
  ConsumerState<PurchaseOrderDetailsScreen> createState() {
    return _PurchaseOrderDetailsScreenState();
  }
}

class _PurchaseOrderDetailsScreenState
    extends ConsumerState<PurchaseOrderDetailsScreen> {
  String apiKey = "";
  List<Doclink> purchaseOrderDoclinks = [];
  bool docsLoading = true;

  @override
  void initState() {
    apiKey = ref.read(userProvider.notifier).getApiKey();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    purchaseOrderDoclinks = await ref
        .read(purchaseOrdersProvider.notifier)
        .getPurchaseOrderDoclinks(apiKey, widget.purchaseOrder.poid);
    setState(() {
      docsLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget addtionalDetailsContent = POAdditionalDetailsCard(
        purchaseOrder: widget.purchaseOrder,
        purchaseOrderDoclinks: purchaseOrderDoclinks);
    if (docsLoading) {
      addtionalDetailsContent = const Center(child: CustomProgreessIndicator());
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        title: Text('# ${widget.purchaseOrder.ponum}'),
      ),
      body: Column(
        children: [
          Hero(
              tag: widget.purchaseOrder.ponum,
              child: POMainDetailsCard(purchaseOrder: widget.purchaseOrder)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: addtionalDetailsContent,
          ),
        ],
      ),
    );
  }
}
