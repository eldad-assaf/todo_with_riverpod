import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_with_riverpod/common/models/task_model.dart';

import '../../features/todo/pages/view_notifications.dart';

class NotificationsHelper {
  final WidgetRef ref;

  NotificationsHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? selectedNotificationPayload;

//from rxdart
  final BehaviorSubject<String?> selectedNotificationSubject =
      BehaviorSubject<String?>();

  initializeNotification() async {
    requestIOSPermissions();
    _configureLocalTimeZone();
    _configureSelectNotificationSubject();
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidRecieveLocalNotification,
    );

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("bell"); // from assets / need to add

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (data) async {
        log('notification payload : ${data.payload}');
        selectedNotificationSubject.add(data.payload); // add to the stream
      },
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String timeZone = "Asia/Jerusalem";
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future onDidRecieveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    showDialog(
      context: ref.context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('View'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  scheduledNotification(
      int days, int hours, int minutes, int seconds, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id ?? 0,
        task.title,
        task.desc,
        tz.TZDateTime.now(tz.local).add(Duration(
            days: days, hours: hours, minutes: minutes, seconds: seconds)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload:
            "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}");
  }

  void _configureSelectNotificationSubject() {
    selectedNotificationSubject.stream.listen((String? payload) async {
      var title = payload!.split('|')[0];
      var body = payload.split('|')[1];
      showDialog(
        context: ref.context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(
            body,
            textAlign: TextAlign.justify,
            maxLines: 4,
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('View'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NotificationsPage(
                      payload: payload,
                    );
                  },
                ));
              },
            )
          ],
        ),
      );
    });
  }
}
