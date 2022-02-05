
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class AuthService {
  Future<FirebaseApp> initializeFirebase({required BuildContext context});
  Future<User?> getCurrentUserSignIn();
  Future<User?> signInWithGoogle({required BuildContext context});
  Future<void> signOut({required BuildContext context});

}