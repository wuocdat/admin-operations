import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tctt_mobile/firebase_options.dart';
import 'package:tctt_mobile/shared/enums.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

class FirebaseService {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.setAutoInitEnabled(true);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log(settings.authorizationStatus.name);

    await _handleMessagesFromFCM();
  }

  static Future<String?> getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM Token: $fcmToken');

    return fcmToken;
  }

  static Future<void> _handleMessagesFromFCM() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Handle messages in the background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle messages in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'app_icon',
              // other properties...
            ),
          ),
        );
      }

      _parseMessDataAndShowLocalNotification(
          message, flutterLocalNotificationsPlugin);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _parseMessDataAndShowLocalNotification(
        message, flutterLocalNotificationsPlugin);
  }

  static void _parseMessDataAndShowLocalNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin plugin,
  ) {
    final messType = message.data['type'];

    if (messType == null) return;

    final typeValue = messType as String;
    switch (typeValue.toENotificationType) {
      case ENotificationType.mission:
        final taskId = message.data['taskId'] as String;
        final notificationId = int.tryParse(taskId) ?? 0;
        final body = message.data['body'] as String;
        const title = "Nhiệm vụ mới";

        plugin.show(
          notificationId,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'app_icon',
              // other properties...
            ),
          ),
          payload: taskId,
        );
        break;

      case ENotificationType.mail:
        // Handle mail notification
        break;

      case ENotificationType.chat:
        final senderName = message.data['title'] as String;
        final notificationId = DateTime.now().hashCode;
        final conversationId = message.data['conversationId'];
        final body = message.data['body'] as String;
        final title = "Tin nhắn mới từ $senderName";

        plugin.show(
          notificationId,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'app_icon',
              // other properties...
            ),
          ),
          payload: conversationId,
        );
        break;
    }
  }
}

extension on String {
  ENotificationType get toENotificationType {
    switch (this) {
      case '1':
        return ENotificationType.mission;
      case '2':
        return ENotificationType.mail;
      default:
        return ENotificationType.chat;
    }
  }
}
