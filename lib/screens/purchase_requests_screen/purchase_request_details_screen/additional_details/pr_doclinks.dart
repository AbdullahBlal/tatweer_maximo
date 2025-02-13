import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/doclink.dart';
import 'package:tatweer_maximo/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_doclinks_item.dart';

class PrDoclinks extends StatelessWidget {
  const PrDoclinks({super.key, required this.purchaseRequestDoclinks});

  final List<Doclink> purchaseRequestDoclinks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: purchaseRequestDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            PrDoclinkItem(docLink: purchaseRequestDoclinks[index])
          ],
        );
      },
    );
  }
}
