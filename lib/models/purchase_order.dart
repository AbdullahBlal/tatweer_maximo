import 'package:tatweer_maximo/models/purchase_order_line.dart';
import 'package:tatweer_maximo/reusable%20functions/number_formatter.dart';


class PurchaseOrder {
  const PurchaseOrder({
    required this.poid,
    required this.ponum,
    required this.potype,
    required this.potypeDescription,
    required this.description,
    required this.buyer,
    required this.status,
    required this.statusDescription,
    required this.department,
    required this.departmentDescription,
    required this.project,
    required this.projectDescription,
    required this.currencyCode,
    required this.totalCost,
    required this.chargeToOrgnization,
    required this.purchaseAgent,
    required this.vendor,
    required this.vendorDescription,
    required this.paymentTerms,
    required this.paymentTermsDetails,
    required this.poLines,
    required this.statusDate,
    required this.orderDate,
    // required this.orderDate,
  });

  final int poid;
  final String ponum;
  final String potype;
  final String buyer;
  final String potypeDescription;
  final String description;
  final String status;
  final String statusDescription;
  final String department;
  final String departmentDescription;
  final String project;
  final String projectDescription;
  final String currencyCode;
  final double totalCost;
  final String chargeToOrgnization;
  final String purchaseAgent;
  final String vendor;
  final String vendorDescription;
  final String paymentTerms;
  final String paymentTermsDetails;
  final List<PurchaseOrderLine> poLines;
  final dynamic statusDate;
  final dynamic orderDate;

  String get toStringTotalCost {
    return displayNumberFormatter.format(totalCost);
  }
}
