import 'dart:async';
import 'dart:convert';

import 'package:e_management/src/models/dette_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    tz.initializeTimeZones(); // <------

    print('tz.initializeTimeZones() ${tz.initializeTimeZones}');
  }

  Future<void> selectNotification(String? payload) async {
    DetteModel dette = getUserDetteFromPayload(payload!);
    cancelNotificationForDette(dette);
    scheduleNotificationForDete(
        dette, "${dette.categorie} arrive bientôt a écheance!");
  }

  showNotification(DetteModel dette, String notificationMessage) async {
    await _flutterLocalNotificationsPlugin.show(
        dette.hashCode,
        dette.categorie,
        notificationMessage,
        NotificationDetails(
            android: AndroidNotificationDetails(
                dette.id.toString(),
                dette.categorie,
                ' ${dette.categorie} écheance pour le payement')),
        payload: jsonEncode(dette));
  }

  void scheduleNotificationForDete(
      DetteModel dette, String notificationMessage) async {
    DateTime now = DateTime.now();
    DateTime detteDate = dette.datePayement;
    Duration difference = now.isAfter(detteDate)
        ? now.difference(detteDate)
        : detteDate.difference(now);

    print('difference $difference');

    _wasApplicationLaunchedFromNotification()
        .then((bool didApplicationLaunchFromNotification) => {
              if (didApplicationLaunchFromNotification &&
                  difference.inDays == 0)
                {scheduleNotificationForNextDette(dette, notificationMessage)}
              else if (!didApplicationLaunchFromNotification &&
                  difference.inDays == 0)
                {showNotification(dette, notificationMessage)}
            });

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        dette.hashCode,
        dette.categorie,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(difference),
        NotificationDetails(
            android: AndroidNotificationDetails(dette.id.toString(),
                dette.categorie, 'To remind you about upcoming birthdays',
                importance: Importance.max, priority: Priority.max)),
        payload: jsonEncode(dette),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void scheduleNotificationForNextDette(
      DetteModel dette, String notificationMessage) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        dette.hashCode,
        dette.categorie,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(new Duration(days: 365)),
        NotificationDetails(
            android: AndroidNotificationDetails(dette.id.toString(),
                dette.categorie, 'To remind you about upcoming birthdays')),
        payload: jsonEncode(dette),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<bool> _wasApplicationLaunchedFromNotification() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    return notificationAppLaunchDetails!.didNotificationLaunchApp;
  }

  DetteModel getUserDetteFromPayload(String payload) {
    Map<String, dynamic> json = jsonDecode(payload);
    DetteModel dette = DetteModel.fromJson(json);
    return dette;
  }

  void cancelNotificationForDette(DetteModel dette) async {
    await _flutterLocalNotificationsPlugin.cancel(dette.hashCode);
  }

  void cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  
}
