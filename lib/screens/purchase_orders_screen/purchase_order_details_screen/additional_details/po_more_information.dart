import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/purchase_order.dart';

class PoMoreInformation extends StatelessWidget {
  const PoMoreInformation({super.key, required this.purchaseOrder});

  final PurchaseOrder purchaseOrder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          purchaseOrder.vendorDescription != ''
              ? ListTile(
                  title: const Text('Vendor'),
                  subtitle: Text(purchaseOrder.vendorDescription),
                )
              : const SizedBox.shrink(),
          purchaseOrder.potypeDescription != ''
              ? ListTile(
                  title: const Text('PO Type'),
                  subtitle: Text(purchaseOrder.potypeDescription),
                )
              : const SizedBox.shrink(),
          purchaseOrder.departmentDescription != ''
              ? ListTile(
                  title: const Text('Department'),
                  subtitle: Text(purchaseOrder.departmentDescription),
                )
              : const SizedBox.shrink(),
          purchaseOrder.projectDescription != ''
              ? ListTile(
                  title: const Text('Project'),
                  subtitle: Text(purchaseOrder.projectDescription),
                )
              : const SizedBox.shrink(),
          purchaseOrder.chargeToOrgnization != ''
              ? ListTile(
                  title: const Text('Charge to Organization'),
                  subtitle: Text(purchaseOrder.chargeToOrgnization),
                )
              : const SizedBox.shrink(),
          purchaseOrder.paymentTermsDetails != ''
              ? ListTile(
                  title: const Text('Payment Terms'),
                  subtitle: Text(purchaseOrder.paymentTermsDetails),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
