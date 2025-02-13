import 'package:intl/intl.dart';
import 'package:tatweer_maximo/reusable%20functions/number_formatter.dart';

final formatter = DateFormat.yMd();

class WorkorderFeeCharge {
  const WorkorderFeeCharge({
    required this.type,
    required this.description,
    required this.linePrice,
  });

  final String type;
  final String description;
  final double linePrice;

  String get toStringLinePrice {
    return displayNumberFormatter.format(linePrice);
  }
}
