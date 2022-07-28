import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String title="yy",
    String body="mm",
    String payload="dd",
  }) async =>
      notifications.show(
        id,
        title,
        body,
        await notificationDetails(),
        payload: payload,
      );

  static Future notificationDetails() async {

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ), // AndroidNotificationDetails
      iOS: IOSNotificationDetails(),
    ); // NotificationDetails
  }
}
