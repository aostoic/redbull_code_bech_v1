import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';

class UserService extends ChangeNotifier {
  Future getUser(uid) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.users)
          .doc(uid)
          .get();

      if (result.exists) {
        return null;
      }

      return result.data();
    } catch (err) {
      print("getUser err: ${err.toString()}");
    }
  }

  Future saveUser(uid, data) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.users)
          .doc(uid)
          .set(data, SetOptions(merge: true))
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (err) {
      print("getUser err: ${err.toString()}");
    }
  }
}
