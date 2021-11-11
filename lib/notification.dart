import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class NotificationCall extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    FlutterLocalNotificationsPlugin _notifications =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _notifications.initialize(initializationSettings);
  }

  //  Notification 1
  Future notificationOne() async {
    final soundOne = "sound_one.mp3";
    var android = AndroidNotificationDetails(
      'channelId',
      'channelName',
      sound: RawResourceAndroidNotificationSound(soundOne.split('.').first),
      playSound: true,
    );
    var platform = NotificationDetails(android: android);
    await _notifications.show(
        0, 'Notification One Clicked', 'Thanks For Clicking', platform,
        payload: 'Welcome to Notification One');
  }

  //  Notification 2
  Future notificationTwo() async {
    // ignore: prefer_const_constructors
    var bigPicture = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      contentTitle: 'Demo Image Notification',
      summaryText: 'Thanks For Clicking',
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );
    final soundTwo = "sound_two.mp3";
    var android = AndroidNotificationDetails('channelId', 'channelName',
        sound: RawResourceAndroidNotificationSound(soundTwo.split('.').first),
        playSound: true,
        styleInformation: bigPicture);
    var platform = NotificationDetails(android: android);
    await _notifications.show(
        0, 'Notification Two Clicked', 'Thanks For Clicking', platform,
        payload: 'Welcome to Notification Two');
  }

  //  Notification 3
  Future notificationThree() async {
    final soundThree = "sound_three.mp3";
    var android = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundThree.split('.').first),
      color: Colors.deepOrange,
      enableLights: true,
      enableVibration: true,
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
    );
    var platform = NotificationDetails(android: android);
    await _notifications.show(
      0,
      'Notification Three Clicked',
      'Thanks For Clicking',
      platform,
    );
  }

  Future scheduledNotification(Position position) async {
    var interval = RepeatInterval.everyMinute;

    var android = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var platform = NotificationDetails(android: android);
    await _notifications.show(
        0, 'Location Fetched Notification', 'Thanks For Clicking', platform,
        payload: 'Welcome to Notification');
    _notifications.periodicallyShow(
      0,
      'Location fetched',
      position.toString(),
      interval,
      platform,
    );
  }
}
