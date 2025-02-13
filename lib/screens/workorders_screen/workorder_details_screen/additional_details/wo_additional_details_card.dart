import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/doclink.dart';
import 'package:tatweer_maximo/models/workorder.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/Wo_doclinks.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/wo_more_information.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/workorder%20plans/wo_plans.dart';

class WOAdditionalDetailsCard extends StatelessWidget {
  const WOAdditionalDetailsCard({super.key, required this.workorderDoclinks, required this.workorder});

  final Workorder workorder;
  final List<Doclink> workorderDoclinks;
  
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
                  Tab(text: 'Plans'),
                  Tab(text: 'Attachments'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                WoMoreInformation(workorder:workorder),
                WOPlans(workorder: workorder),
                WoDoclinks(workorderDoclinks: workorderDoclinks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
