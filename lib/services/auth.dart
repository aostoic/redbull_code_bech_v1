import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class AuthService extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  User? _user;
  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;

    FirebaseAuth.instance.currentUser;

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    }

    FirebaseAuth.instance.signOut();

    _isLoading = false;
  }

  Future<bool> checkAuth() async {
    if (auth.currentUser == null) {
      return false;
    }

    _user = auth.currentUser;
    return true;
  }

  Future<String?> createUserWithEmailAndPassword(email, password) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;

      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return "Firebase communication error";
    }
  }

  Future<String?> restartPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      return null;
    } catch (e) {
      return "Firebase communication error";
    }
  }

  Future<String> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

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

      return e.message.toString();
    }
  }

  Future<String> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return 'No se completo el proceso de inicio de sesión';
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _user = result.user;

      return '';
    } catch (e) {
      return e.toString();
    }
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
