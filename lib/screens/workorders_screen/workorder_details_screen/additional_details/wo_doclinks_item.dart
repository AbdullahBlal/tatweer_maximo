import 'package:flutter/material.dart';
import 'package:tatweer_maximo/models/doclink.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_maximo/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:tatweer_maximo/widgets/custom_progreess_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

class WoDoclinkItem extends ConsumerStatefulWidget {
  const WoDoclinkItem({super.key, required this.docLink});

  final Doclink docLink;

  @override
  ConsumerState<WoDoclinkItem> createState() {
    return _WoDoclinkItemState();
  }
}

class _WoDoclinkItemState extends ConsumerState<WoDoclinkItem> {
  String apiKey = '';
  var downloading = false;

  void initState() {
    // request permession to manage external storage when attacment page is initialized
    apiKey = ref.read(userProvider.notifier).getApiKey();
    super.initState();
  }

  Future<void> downloadAndOpenFile(String url, String filename) async {
    setState(() {
      downloading = true;
    });
    
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'apikey': apiKey,
    });
    var bytes = response.bodyBytes;
    Directory? appDocDir = Directory("");
    // Get the app's external storage directory to save the file
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      // you can read and write in ApplicationDocumentsDirectory (getApplicationDocumentsDirectory()) but the data can't be accessed outside of the app. thus, i've used getExternalStorageDirectory()
      appDocDir = await getExternalStorageDirectory();
    } else {
      appDocDir = await getApplicationDocumentsDirectory();
    }
    String filePath = '${appDocDir!.path}/$filename';

    // Write the file
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    // Now open the file using a suitable application
    // For PDF files, you can use the 'open_file' plugin
    // Make sure to add the 'open_file' dependency in your pubspec.yaml
    // Example: open_file: ^4.0.1

    // To open a file
    setState(() {
      downloading = false;
    });
    OpenFile.open(filePath);
  }

  Future<void> downloadFile(String url, String filename) async {
    setState(() {
      downloading = true;
    });
    try {
      // Initialize notifications
      // await NotificationService.initialize();

      Directory directory = Directory("");
      if (Platform.isAndroid) {
        // Redirects it to download folder in android
        directory = Directory("/storage/emulated/0/Download");
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath = '${directory.path}/$filename';

      // Create Dio instance
      final dio = Dio();

      // Download the file
      await dio.download(
        url,
        filePath,
        options: Options(
          headers: {
            'apikey': apiKey, // Set the content-length.
          },
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            // NotificationService.showProgressNotification(int.parse(progress));
            print('Progress: $progress%');
          }
        },
      );

      // Notify that the download is complete
      // NotificationService.showDownloadCompleteNotification();
      setState(() {
        downloading = false;
      });
      print('File downloaded to: $filePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.docLink.filename),
      trailing: IconButton(
        onPressed: () {
          downloadAndOpenFile(widget.docLink.href, widget.docLink.filename);
        },
        icon: downloading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: Center(
                    child: CustomProgreessIndicator()),
              )
            : const Icon(Icons.download),
      ),
    );
  }
}
