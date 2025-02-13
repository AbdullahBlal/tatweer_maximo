import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/purchase_request.dart';

class PrMoreInformation extends StatelessWidget {
  const PrMoreInformation({super.key, required this.purchaseRequest});

  final PurchaseRequest purchaseRequest;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          purchaseRequest.vendorDescription != ''
              ? ListTile(
                  title: const Text('Vendor'),
                  subtitle: Text(purchaseRequest.vendorDescription),
                )
              : const SizedBox.shrink(),
          purchaseRequest.prtypeDescription != ''
              ? ListTile(
                  title: const Text('PO Type'),
                  subtitle: Text(purchaseRequest.prtypeDescription),
                )
              : const SizedBox.shrink(),
          purchaseRequest.departmentDescription != ''
              ? ListTile(
                  title: const Text('Department'),
                  subtitle: Text(purchaseRequest.departmentDescription),
                )
              : const SizedBox.shrink(),
          purchaseRequest.projectDescription != ''
              ? ListTile(
                  title: const Text('Project'),
                  subtitle: Text(purchaseRequest.projectDescription),
                )
              : const SizedBox.shrink(),
          purchaseRequest.chargeToOrgnization != ''
              ? ListTile(
                  title: const Text('Charge to Organization'),
                  subtitle: Text(purchaseRequest.chargeToOrgnization),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
