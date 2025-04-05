import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleAlarm(DateTime scheduledTime) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    '모닝콜 알림',
    '일어날 시간이에요!',
    tz.TZDateTime.from(scheduledTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'alarm_channel',
        'Alarm',
        importance: Importance.max,
        priority: Priority.high,
        fullScreenIntent: true,
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time, // 반복 시 사용
  );
}
class AlarmScheduler {
  final AudioPlayer _player = AudioPlayer();

  void scheduleAlarm(DateTime alarmTime) {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      final now = DateTime.now();

      // 목표 시간 ±15초 범위에서 울림
      if (now.isAfter(alarmTime.subtract(const Duration(seconds: 15))) &&
          now.isBefore(alarmTime.add(const Duration(seconds: 15)))) {
        timer.cancel();
        _playAlarm();
      }
    });
  }

  Future<void> _playAlarm() async {
    await _player.play(AssetSource('sounds/alarm.mp3'));
  }
}
