import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoriesService extends ChangeNotifier {
  Future<dynamic> getCategories() async {
    final result =
        await FirebaseFirestore.instance.collection("categories").get();
    return result.docs;
  }
}
