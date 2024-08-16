import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math'; // Import this library

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shake Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShakeDetector(),
    );
  }
}

class ShakeDetector extends StatefulWidget {
  @override
  _ShakeDetectorState createState() => _ShakeDetectorState();
}

class _ShakeDetectorState extends State<ShakeDetector> {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static const double shakeThreshold = 20.0;

  @override
  void initState() {
    super.initState();

    // Initialize the notification plugin
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the acceleration magnitude
      double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (acceleration > shakeThreshold) {
        _showNotification();
      }
    });
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'shake_channel',
      'Shake Notification',
      channelDescription: 'Triggered when the device is shaken',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Shake Detected!',
      'You just shook your phone!',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shake Notification'),
      ),
      body: Center(
        child: Text('Shake your phone to trigger a notification!'),
      ),
    );
  }
}
