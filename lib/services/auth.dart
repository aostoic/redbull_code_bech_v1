// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'dart:convert';
// import 'dart:math';

// import 'package:crypto/crypto.dart';

// import 'package:flutter/foundation.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Generates a cryptographically secure random nonce, to be included in a
// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class AuthenticationService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  static Future<String?> createUserWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future restartPassword(email) async {
    try {
      final sendEmail =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return null;
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      return e;
    }
  }

  static Future<String?> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<String> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return 'No se completo el proceso de inicio de sesión';
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      return '';
    } catch (e) {
      return 'No se completo el proceso de inicio de sesión';
    }
  }

  Future logout() async {
    FirebaseAuth.instance.currentUser;
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
  }

  // Future<UserCredential> signInWithApple() async {
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);

  //   // Request credential for the currently signed in Apple account.
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     nonce: nonce,
  //   );

  //   // Create an `OAuthCredential` from the credential returned by Apple.
  //   final oauthCredential = OAuthProvider("apple.com").credential(
  //     idToken: appleCredential.identityToken,
  //     rawNonce: rawNonce,
  //   );

  //   // Sign in the user with Firebase. If the nonce we generated earlier does
  //   // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //   return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  // }

  // static Future<String> signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   return "signOut";
  // }

}
