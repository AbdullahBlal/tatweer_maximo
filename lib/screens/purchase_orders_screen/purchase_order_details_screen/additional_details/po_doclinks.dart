import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/screens/purchase_orders_screen/purchase_order_details_screen/additional_details/po_doclinks_item.dart';

class PoDoclinks extends StatelessWidget {
  const PoDoclinks({super.key, required this.purchaseOrderDoclinks});

  final List<Doclink> purchaseOrderDoclinks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: purchaseOrderDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            PoDoclinkItem(docLink: purchaseOrderDoclinks[index])
          ],
        );
      },
    );
  }
}
