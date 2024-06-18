import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/firebase_options.dart';
import 'package:tctt_mobile/shared/enums.dart';

late FirebaseMessaging messaging;

Future<void> initializeFirebaseService() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  logger.info(settings.authorizationStatus.name);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<String?> getFCMToken() async {
  final fcmToken = await messaging.getToken();
  logger.info('FCM Token: $fcmToken');

  return fcmToken;
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeNotifications();
  showFlutterNotification(message, false);
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> initializeNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message,
    [bool showFCMNotification = true]) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && showFCMNotification) {
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
        ),
      ),
    );
  }

  final messType = message.data['type'];

  if (messType == null) return;

  final typeValue = messType as String;
  switch (typeValue.toENotificationType) {
    case ENotificationType.mission:
      final taskId = message.data['taskId'] as String;
      final notificationId = int.tryParse(taskId) ?? 0;
      final body = message.data['body'] as String;
      const title = "Nhiệm vụ mới";

      flutterLocalNotificationsPlugin.show(
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
        payload: jsonEncode({
          "type": typeValue,
          "data": taskId,
        }),
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

      flutterLocalNotificationsPlugin.show(
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
        payload: jsonEncode({
          "type": typeValue,
          "data": conversationId,
        }),
      );
      break;
  }
}
