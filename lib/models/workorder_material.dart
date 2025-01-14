import 'package:intl/intl.dart';
import 'package:tatweer_approval/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class WorkorderMaterial {
  const WorkorderMaterial({
    required this.description,
    required this.quantity,
    required this.unitCost,
    required this.lineCost,
    required this.linePrice,
    required this.storeroom
  });

  final String description;
  final double quantity;
  final double unitCost;
  final double lineCost;
  final double linePrice;
  final String storeroom;

  String get toStringQuantity {
    return quantity.toString();
  }

  String get toStringUnitCost {
    return displayNumberFormatter.format(unitCost);
  }

  String get toStringLineCost {
    return displayNumberFormatter.format(lineCost);
  }

  String get toStringLinePrice {
    return displayNumberFormatter.format(linePrice);
  }
}
