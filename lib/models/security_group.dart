import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class SecurityGroup {
  const SecurityGroup({
    required this.mobileSCWeight,
    required this.groupname,
    required this.mobileSC,
    required this.mobileSCDescription,
  });

  final int mobileSCWeight;
  final String groupname;
  final String mobileSC;
  final String mobileSCDescription;

}
