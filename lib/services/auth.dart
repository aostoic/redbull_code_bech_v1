import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  // static Future<User?> signInWithGoogle() async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     UserCredential userCredential;

  //     if (kIsWeb) {
  //       var googleProvider = GoogleAuthProvider();
  //       userCredential = await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final googleAuthCredential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       userCredential = await _auth.signInWithCredential(googleAuthCredential);
  //     }

  //     final user = userCredential.user;
  //     return user;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  static Future<User?> createUserWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<String> signOut() async {
    await FirebaseAuth.instance.signOut();
    return "signOut";
  }
}
