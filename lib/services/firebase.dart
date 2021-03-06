// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseService extends ChangeNotifier {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  String _messagingToken = "";
  String get messagingToken => _messagingToken;

  set messagingToken(String value) {
    _messagingToken = value;
    notifyListeners();
  }

  FirebaseService() {
    if (!kIsWeb) {
      getToken();
      if (Platform.isIOS) {
        getPermissions();

        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
        FirebaseMessaging.onMessage.listen(_onMessage);
        FirebaseMessaging.onBackgroundMessage(_messageHandler);
      }
    }
  }

  Future getPermissions() async {
    if (await Permission.notification.request().isGranted) {
    } else {
      PermissionStatus status = await Permission.notification.status;
      final result = await Permission.notification.request();
    }
  }

  Future<void> getToken() async {
    String? token = await messaging.getToken();
    messagingToken = token!;
    print("Messaging Token: $messagingToken");
  }

  static Future<String?> checkToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  Future<void> _messageHandler(RemoteMessage event) async {
    print('Background Message: ${event.notification!.body}');
  }

  Future<void> _onMessage(RemoteMessage event) async {
    print("New Notification - Opened App");
    print("Notification Body: ${event.notification!.body}");
    print("Notification Values: ${event.data.values}");
  }

  Future<void> _onMessageOpenedApp(RemoteMessage event) async {
    print('Notification Pressed $event');
  }
}
