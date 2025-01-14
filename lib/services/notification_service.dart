import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print(details);
      },
    );
  }

  static Future<void> showProgressNotification(int progress) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_channel_id',
      'Progress Notifications',
      channelDescription: 'Channel for download progress notifications',
      icon: 'app_icon',
      playSound: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      0,
      'Downloading File',
      'Progress: $progress%',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static Future<void> showDownloadCompleteNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_complete_channel_id',
      'Download Complete Notifications',
      channelDescription: 'Channel for download complete notifications',
      icon: 'app_icon',
      playSound: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      1,
      'Download Complete',
      'Your file has been downloaded successfully.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
