import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/workorder.dart';

class WoMoreInformation extends StatelessWidget {
  const WoMoreInformation({super.key, required this.workorder});

  final Workorder workorder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          workorder.description != ''
              ? ListTile(
                  title: const Text('Description'),
                  subtitle: Text(workorder.description),
                )
              : const SizedBox.shrink(),
          workorder.departmentDescription != ''
              ? ListTile(
                  title: const Text('Department Description'),
                  subtitle: Text(workorder.departmentDescription),
                )
              : const SizedBox.shrink(),
          workorder.locationDescription != ''
              ? ListTile(
                  title: const Text('Location Description'),
                  subtitle: Text(workorder.locationDescription),
                )
              : const SizedBox.shrink(),
          workorder.ownergroupDescription != ''
              ? ListTile(
                  title: const Text('Ownergroup'),
                  subtitle: Text(workorder.ownergroupDescription),
                )
              : const SizedBox.shrink(),
          workorder.technician != ''
              ? ListTile(
                  title: const Text('Technician'),
                  subtitle: Text(workorder.technician),
                )
              : const SizedBox.shrink(),
          workorder.planner != ''
              ? ListTile(
                  title: const Text('Planner'),
                  subtitle: Text(workorder.planner),
                )
              : const SizedBox.shrink(),
          workorder.serviceProvider != ''
              ? ListTile(
                  title: const Text('Service Provider'),
                  subtitle: Text(workorder.serviceProvider),
                )
              : const SizedBox.shrink(),
          workorder.schedStartDate != null
              ? ListTile(
                  title: const Text('Scheduled Visit'),
                  subtitle: Text(workorder.toStringSchedStartDate),
                )
              : const SizedBox.shrink(),
          workorder.reportDate != null
              ? ListTile(
                  title: const Text('Report Date'),
                  subtitle: Text(workorder.toStringReportDate),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
