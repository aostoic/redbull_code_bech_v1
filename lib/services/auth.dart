import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  Future<String> restartPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      return '';
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

  Future<String> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
        rawNonce: rawNonce,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      _user = result.user;

      return '';
    } catch (e) {
      return e.toString();
    }
  }
}
