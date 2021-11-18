import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
// import 'package:permission_handler/permission_handler.dart';

class FirebaseService extends ChangeNotifier {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseService() {
    getToken();
    // getPermissions();

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("notificacion recibida con la app abierta");
      print(event.notification!.body);
      print(event.data.values);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('accion a ejecutar al apretar la notificacion! $message');
    });

    // data en segundo plano
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  // Future getPermissions() async {
  //   if (await Permission.notification.request().isGranted) {
  //     print("AQUI");
  //   }
  // }

  Future<void> getToken() async {
    String? token = await messaging.getToken();
    messagingToken = token!;
    print(token);
  }

  static Future<String?> checkToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  String _messagingToken = "";
  String get messagingToken => _messagingToken;

  set messagingToken(String value) {
    _messagingToken = value;
    notifyListeners();
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }
}
