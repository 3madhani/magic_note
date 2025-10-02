import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);
    tz.initializeTimeZones();
  }

  /// Schedule a one-time or repeating notification
  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    RepeatInterval? repeatInterval,
  }) async {
    if (repeatInterval != null) {
      await _plugin.periodicallyShow(
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        id,
        title,
        body,
        repeatInterval,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    } else {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }
}
