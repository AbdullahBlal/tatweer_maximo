import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorder_details_screen/additional_details/wo_doclinks_item.dart';

class WoDoclinks extends StatefulWidget {
  const WoDoclinks({super.key, required this.workorderDoclinks});

  final List<Doclink> workorderDoclinks;

  @override
  State<WoDoclinks> createState() => _WoDoclinksState();
}

class _WoDoclinksState extends State<WoDoclinks> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.workorderDoclinks.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            WoDoclinkItem(docLink: widget.workorderDoclinks[index])
          ],
        );
      },
    );
  }
}
