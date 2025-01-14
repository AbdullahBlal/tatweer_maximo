import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_doclinks_item.dart';
import 'package:permission_handler/permission_handler.dart';

class PrDoclinks extends StatefulWidget {
  const PrDoclinks({super.key, required this.purchaseRequestDoclinks});

  final List<Doclink> purchaseRequestDoclinks;

  @override
  State<PrDoclinks> createState() => _PrDoclinksState();
}

class _PrDoclinksState extends State<PrDoclinks> {

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
      itemCount: widget.purchaseRequestDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            PrDoclinkItem(docLink: widget.purchaseRequestDoclinks[index])
          ],
        );
      },
    );
  }
}
