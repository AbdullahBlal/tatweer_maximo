import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/models/purchase_request.dart';
import 'package:tatweer_approval/providers/purchase_request_provider.dart';
import 'package:tatweer_approval/providers/user_provider.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_additional_details_card.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/pr_main_details_card.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';

class PurchaseRequestDetailsScreen extends ConsumerStatefulWidget {
  const PurchaseRequestDetailsScreen(
      {super.key, required this.purchaseRequest});

  final PurchaseRequest purchaseRequest;

  @override
  ConsumerState<PurchaseRequestDetailsScreen> createState() {
    return _PurchaseOrderDetailsScreenState();
  }
}

class _PurchaseOrderDetailsScreenState
    extends ConsumerState<PurchaseRequestDetailsScreen> {
  String apiKey = "";
  List<Doclink> purchaseRequestDoclinks = [];
  bool docsLoading = true;

  @override
  void initState() {
    apiKey = ref.read(userProvider.notifier).getApiKey();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    purchaseRequestDoclinks = await ref
        .read(purchaseRequestsProvider.notifier)
        .getPurchaseRequestDoclinks(apiKey, widget.purchaseRequest.prid);
    setState(() {
      docsLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget addtionalDetailsContent = PRAdditionalDetailsCard(
        purchaseRequest: widget.purchaseRequest,
        purchaseRequestDoclinks: purchaseRequestDoclinks);
    if (docsLoading) {
      addtionalDetailsContent = const Center(
        child: CustomProgreessIndicator()
      );
    }
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          centerTitle: true,
          title: Text('# ${widget.purchaseRequest.prnum}'),
        ),
        body: Column(
            children: [
              Hero(
                  tag: widget.purchaseRequest.prnum,
                  child: PRMainDetailsCard(
                      purchaseRequest: widget.purchaseRequest)),
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
