import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class MainCard {
  const MainCard({
    required this.index,
    required this.title,
    required this.iconPath,
    required this.recordsTotal,
  });

  final int index;
  final String title;
  final String iconPath;
  final dynamic recordsTotal;
}
