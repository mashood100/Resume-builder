import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool get isAuthenticated => _authService.isAuthenticated;
  bool get isLoading => _authService.isLoading;
  String? get errorMessage => _authService.errorMessage;

  // Sign Up with Email and Password
  Future<bool> signUp(String email, String password, String name) async {
    return await _authService.signUpWithEmail(email, password, name);
  }

  // Login with Email and Password
  Future<bool> login(String email, String password) async {
    return await _authService.loginWithEmail(email, password);
  }

  // Login with Google
  Future<bool> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }

  // Sign Out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Update User Profile
  Future<bool> updateProfile({String? displayName, String? photoURL}) async {
    return await _authService.updateUserProfile(
      displayName: displayName,
      photoURL: photoURL,
    );
  }

  // Change Password
  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    return await _authService.changePassword(currentPassword, newPassword);
  }
}
