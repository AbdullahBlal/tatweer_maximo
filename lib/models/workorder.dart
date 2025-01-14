import 'package:tatweer_approval/models/workorder_feecharge.dart';
import 'package:tatweer_approval/models/workorder_material.dart';
import 'package:tatweer_approval/models/workorder_service.dart';
import 'package:tatweer_approval/reusable%20functions/datetime_format.dart';
import 'package:tatweer_approval/reusable%20functions/number_formatter.dart';
class Workorder {
  const Workorder({
    required this.workorderid,
    required this.wonum,
    required this.description,
    required this.status,
    required this.statusDescription,
    required this.worktype,
    required this.reportDate,
    required this.schedStartDate,
    required this.estimatedMaterialCost,
    required this.estimatedTotalPrice,
    required this.department,
    required this.departmentDescription,
    required this.location,
    required this.locationDescription,
    required this.locationIsUint,
    required this.serviceProvider,
    required this.ownergroupDescription,
    required this.technician,
    required this.planner,
    required this.woMaterials,
    required this.woServices,
    required this.woFeeCharges
  });

  final int workorderid;
  final String wonum;
  final String description;
  final String status;
  final String statusDescription;
  final String worktype;
  final dynamic reportDate;
  final dynamic schedStartDate;
  final double estimatedMaterialCost;
  final double estimatedTotalPrice;
  final String department;
  final String departmentDescription;
  final String location;
  final String locationDescription;
  final String serviceProvider;
  final String ownergroupDescription;
  final String technician;
  final String planner;
  final bool locationIsUint;
  final List<WorkorderMaterial> woMaterials;
  final List<WorkorderService> woServices;
  final List<WorkorderFeeCharge> woFeeCharges;

  String get toStringEstimatedMaterialCost {
    return displayNumberFormatter.format(estimatedMaterialCost);
  }

  String get toStringEstimatedTotalPrice {
    return displayNumberFormatter.format(estimatedTotalPrice);
  }

  String get toStringReportDate {
    return displayDateFormatter.format(reportDate);
  }

  String get toStringSchedStartDate {
    return displayDateTimeFormatter.format(schedStartDate);
  }
}
