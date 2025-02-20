import 'package:intl/intl.dart';
import 'package:tatweer_maximo/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class PurchaseOrderLine {
  const PurchaseOrderLine({
    required this.poLineid,
    required this.polinenum,
    required this.lineType,
    required this.description,
    required this.quantity,
    required this.unitCost,
    required this.vat,
    required this.loadedCost,
    required this.isDiscountApplied,
    required this.originallineCost,
    required this.requestedByName,
    required this.storeloc,
    required this.glAccount
  });

  final int poLineid;
  final int polinenum;
  final String lineType;
  final String description;
  final double quantity;
  final double unitCost;
  final double vat;
  final double loadedCost;
  final bool isDiscountApplied;
  final double originallineCost;
  final String requestedByName;
  final String storeloc;
  final String glAccount;

  String get toStringQuantity {
    return quantity.toString();
  }

  String get toStringUnitCost {
    return displayNumberFormatter.format(unitCost);
  }

  String get toStringVat {
    return displayNumberFormatter.format(vat);
  }

  String get toStringOriginallineCost {
    return displayNumberFormatter.format(originallineCost);
  }

  String get toStringLoadedCost {
    return displayNumberFormatter.format(loadedCost);
  }
}
