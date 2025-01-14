import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Doclink {
  const Doclink({
    required this.ownerid,
    required this.docinfoid,
    required this.identifier,
    required this.attachmentSize,
    required this.createby,
    required this.title,
    required this.description,
    required this.filename,
    required this.format,
    required this.href
  });

  final int ownerid;
  final int docinfoid;
  final String identifier;
  final int attachmentSize;
  final String createby;
  final String title;
  final String description;
  final String filename;
  final String format;
  final String href;
}
