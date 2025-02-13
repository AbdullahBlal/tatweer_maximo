import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/workorder.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/workorder%20plans/wo_feecharges.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/workorder%20plans/wo_materials.dart';
import 'package:tatweer_maximo/screens/workorders_screen/workorder_details_screen/additional_details/workorder%20plans/wo_services.dart';

class WOPlans extends StatefulWidget {
  const WOPlans({super.key, required this.workorder});

  final Workorder workorder;

  @override
  State<WOPlans> createState() => _WOPlansState();
}

class _WOPlansState extends State<WOPlans> with TickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         TabBar.secondary(
          controller: _tabController,
          tabAlignment: TabAlignment.center,
          tabs: const [
            Tab(text: 'Materials'),
            Tab(text: 'Services'),
            Tab(text: 'Fees and Charges'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              WoMaterials(woMaterials: widget.workorder.woMaterials),
              WoServices(woServices: widget.workorder.woServices),
              WoFeeCharges(woFeeCharges: widget.workorder.woFeeCharges),
            ],
          ),
        ),
      ],
    );
  }
}
