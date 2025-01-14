import 'package:intl/intl.dart';
import 'package:tatweer_approval/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class PurchaseRequestLine {
  const PurchaseRequestLine({
    required this.prLineid,
    required this.prLineNum,
    required this.lineType,
    required this.description,
    required this.quantity,
    required this.unitCost,
    required this.vat,
    required this.loadedCost,
    required this.requestedByName,
    required this.storeloc,
    required this.glAccount
  });

  final int prLineid;
  final int prLineNum;
  final String lineType;
  final String description;
  final double quantity;
  final double unitCost;
  final double vat;
  final double loadedCost;
  final String requestedByName;
  final String storeloc;
  final String glAccount;


  String get toStringPrLineNum {
    return quantity.toString();
  }

  String get toStringQuantity {
    return quantity.toString();
  }

  String get toStringUnitCost {
    return displayNumberFormatter.format(unitCost);
  }

  String get toStringVat {
    return displayNumberFormatter.format(vat);
  }

  String get toStringLoadedCost {
    return displayNumberFormatter.format(loadedCost);
  }
}
