import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorder_details_screen/additional_details/wo_doclinks_item.dart';

class WoDoclinks extends StatelessWidget {
  const WoDoclinks({super.key, required this.workorderDoclinks});

  final List<Doclink> workorderDoclinks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workorderDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            WoDoclinkItem(docLink: workorderDoclinks[index])
          ],
        );
      },
    );
  }
}
