import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/models/purchase_request.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_doclinks.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_lines.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_request_details_screen/additional_details/pr_more_information.dart';

class PRAdditionalDetailsCard extends StatelessWidget {
  const PRAdditionalDetailsCard({super.key, required this.purchaseRequestDoclinks, required this.purchaseRequest});

  final PurchaseRequest purchaseRequest;
  final List<Doclink> purchaseRequestDoclinks;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              spreadRadius: 0.1,
              blurRadius: 1,
              offset: const Offset(0, 0.1), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            colors: [
             Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3)),
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: const Text('Additional Details'),
              centerTitle: true,
              bottom: const TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                tabs: [
                  Tab(text: 'Information'),
                  Tab(text: 'Lines'),
                  Tab(text: 'Attachments'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                PrMoreInformation(purchaseRequest:purchaseRequest),
                PrLines(prLines: purchaseRequest.prLines),
                PrDoclinks(purchaseRequestDoclinks: purchaseRequestDoclinks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
