import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticateUser() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Confirm your screen lock Pin, Pattern, or Password',
        options: const AuthenticationOptions(
          biometricOnly: false,
          useErrorDialogs: false,
        ),
      );
    } catch (e) {
      debugPrint('Authentication Error: $e');
      return false;
    }
  }
}