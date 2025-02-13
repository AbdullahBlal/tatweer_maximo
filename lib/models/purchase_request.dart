import 'package:intl/intl.dart';
import 'package:tatweer_maximo/models/purchase_request_line.dart';
import 'package:tatweer_maximo/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class PurchaseRequest {
  const PurchaseRequest({
    required this.prid,
    required this.prnum,
    required this.prtype,
    required this.prtypeDescription,
    required this.description,
    required this.status,
    required this.statusDescription,
    required this.department,
    required this.departmentDescription,
    required this.project,
    required this.projectDescription,
    required this.totalCost,
    required this.chargeToOrgnization,
    required this.vendor,
    required this.vendorDescription,
    required this.prLines,
    required this.statusDate,
    required this.issueDate,
  });

  final int prid;
  final String prnum;
  final String prtype;
  final String prtypeDescription;
  final String description;
  final String status;
  final String statusDescription;
  final String department;
  final String departmentDescription;
  final String project;
  final String projectDescription;
  final double totalCost;
  final String chargeToOrgnization;
  final String vendor;
  final String vendorDescription;
  final List<PurchaseRequestLine> prLines;
  final dynamic statusDate;
  final dynamic issueDate;

  String get toStringTotalCost {
    return displayNumberFormatter.format(totalCost);
  }
}
