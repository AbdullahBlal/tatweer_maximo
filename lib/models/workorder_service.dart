import 'package:intl/intl.dart';
import 'package:tatweer_approval/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class WorkorderService {
  const WorkorderService({
    required this.description,
    required this.quantity,
    required this.linePrice,
  });

  final String description;
  final double quantity;
  final double linePrice;

  String get toStringQuantity {
    return quantity.toString();
  }

  String get toStringLinePrice {
    return displayNumberFormatter.format(linePrice);
  }
}
