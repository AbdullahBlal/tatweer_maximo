import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/screens/purchase_orders_screen/purchase_order_details_screen/additional_details/po_doclinks_item.dart';
import 'package:permission_handler/permission_handler.dart';

class PoDoclinks extends StatefulWidget {
  const PoDoclinks({super.key, required this.purchaseOrderDoclinks});

  final List<Doclink> purchaseOrderDoclinks;

  @override
  State<PoDoclinks> createState() => _PoDoclinksState();
}

class _PoDoclinksState extends State<PoDoclinks> {

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.isPermanentlyDenied) {
      // The user has permanently denied the permission
      await openAppSettings(); // Open app settings so the user can grant permissions manually
    } else {
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print('Storage permission granted');
      } else if (status.isDenied) {
        print('Storage permission denied');
      } else if (status.isPermanentlyDenied) {
        print('Storage permission permanently denied');
        await openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.purchaseOrderDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            PoDoclinkItem(docLink: widget.purchaseOrderDoclinks[index])
          ],
        );
      },
    );
  }
}
