import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> cancel(int id) async {
    print("[NotificationService] Cancelling notification with id: $id");
    await _plugin.cancel(id);
  }

  static Future<List<PendingNotificationRequest>>
  getScheduledNotifications() async {
    final pending = await _plugin.pendingNotificationRequests();
    print(
      "[NotificationService] Pending notifications count: ${pending.length}",
    );
    for (var p in pending) {
      print("-> id=${p.id}, title=${p.title}, body=${p.body}");
    }
    return pending;
  }

  /// Check whether the app can schedule exact alarms (Android 12+)
  static Future<bool> hasExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final can = await androidPlugin?.canScheduleExactNotifications() ?? false;
    print("[NotificationService] Exact Alarm Permission: $can");
    return can;
  }

  // Call once at app start
  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _plugin.initialize(initSettings);
    print("[NotificationService] Initialized FlutterLocalNotifications");

    // Create notification channel on Android (safe to call every start)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'reminder_channel', // id
      'Reminders', // name
      description: 'Reminder notifications',
      importance: Importance.max,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    print("[NotificationService] Reminder channel created/ensured");
  }

  static Future<void> requestBatteryOptimizationException() async {
    if (Platform.isAndroid) {
      const intent = AndroidIntent(
        action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
        data: 'package:com.example.magic_note',
      );
      await intent.launch();
    }
  }

  /// Open system settings where user can grant exact-alarm permission
  static Future<void> requestExactAlarmPermission() async {
    if (!Platform.isAndroid) return;
    print("[NotificationService] Requesting Exact Alarm Permission...");
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      package: 'com.example.magic_note',
    );
    await intent.launch();
  }

  /// Request POST_NOTIFICATIONS permission (Android 13+)
  static Future<bool> requestNotificationPermission() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.notification.status;
    print("[NotificationService] Notification Permission Status: $status");
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      print(
        "[NotificationService] Notification Permission Requested -> $result",
      );
      return result.isGranted;
    }
    return true;
  }

  /// Schedule a notification at [dateTime].
  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    bool repeatDaily = false,
    bool repeatWeekly = false,
  }) async {
    final scheduled = tz.TZDateTime.from(dateTime, tz.local);
    print(
      "[NotificationService] Scheduling notification (id=$id) at: $scheduled | daily=$repeatDaily weekly=$repeatWeekly",
    );

    // sanity: don't schedule in the past
    if (!scheduled.isAfter(tz.TZDateTime.now(tz.local))) {
      print("[NotificationService] Date is in the past → showing instantly");
      await showInstant(id: id, title: title, body: body);
      return;
    }

    // Ensure exact-alarm permission on Android if needed.
    if (Platform.isAndroid) {
      final canExact = await hasExactAlarmPermission();
      if (!canExact) {
        print(
          "[NotificationService] Cannot schedule exact alarm (permission denied)",
        );
        return;
      }
    }

    final androidDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        channelDescription: 'Reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    if (repeatDaily) {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        androidDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: "daily",
        matchDateTimeComponents: DateTimeComponents.time,
      );
      print("[NotificationService] Daily notification scheduled ✅");
    } else if (repeatWeekly) {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        androidDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: "weekly",
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      print("[NotificationService] Weekly notification scheduled ✅");
    } else {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        androidDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: "one-time",
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
      print("[NotificationService] One-time notification scheduled ✅");
    }
    final pending = await _plugin.pendingNotificationRequests();
    for (var n in pending) {
      debugPrint(
        "⏰ Pending Notification: ${n.id}, title: ${n.title}, body: ${n.body}",
      );
    }
  }

  /// Show an instant/test notification
  static Future<void> showInstant({
    required int id,
    required String title,
    required String body,
  }) async {
    print("[NotificationService] Showing INSTANT notification (id=$id)");
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_channel',
          'Instant',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
