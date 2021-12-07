import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';

class UserService extends ChangeNotifier {
  Future getUser(uid) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.users)
          .doc(uid)
          .get();

      if (!result.exists) {
        return null;
      }

      return result.data();
    } catch (err) {
      print("getUser err: ${err.toString()}");
    }
  }

  Future<bool> saveUser(uid, name) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.users)
          .doc(uid)
          .set({'uid': uid, 'name': name}, SetOptions(merge: true))
          .then((value) => true)
          .catchError((error) => false);

      return result;
    } catch (err) {
      print("getUser err: ${err.toString()}");
      return false;
    }
  }
}
