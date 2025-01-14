import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/models/workorder.dart';
import 'package:tatweer_approval/providers/user_provider.dart';
import 'package:tatweer_approval/providers/workorders_provider.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorder_details_screen/additional_details/wo_additional_details_card.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorder_details_screen/wo_main_details_card.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';

class WorkorderDetailsScreen extends ConsumerStatefulWidget {
  const WorkorderDetailsScreen({super.key, required this.workorder});

  final Workorder workorder;

  @override
  ConsumerState<WorkorderDetailsScreen> createState() {
    return _WorkorderDetailsScreenState();
  }
}

class _WorkorderDetailsScreenState
    extends ConsumerState<WorkorderDetailsScreen> {
  String apiKey = "";
  List<Doclink> workorderDoclinks = [];
  bool docsLoading = true;

  @override
  void initState() {
    apiKey = ref.read(userProvider.notifier).getApiKey();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    workorderDoclinks = await ref
        .read(workordersProvider.notifier)
        .getWorkorderDoclinks(apiKey, widget.workorder.workorderid);
    setState(() {
      docsLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget addtionalDetailsContent = WOAdditionalDetailsCard(
        workorder: widget.workorder,
        workorderDoclinks: workorderDoclinks);
    if (docsLoading) {
      addtionalDetailsContent = const Center(child: CustomProgreessIndicator());
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        title: Text('# ${widget.workorder.wonum}'),
      ),
      body: Column(
        children: [
          Hero(
              tag: widget.workorder.wonum,
              child: WOMainDetailsCard(workorder: widget.workorder)),
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
