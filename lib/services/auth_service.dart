import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  
  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  // Email & Password Sign Up
  Future<bool> signUpWithEmail(String email, String password, String name) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update user profile with name
      await result.user?.updateDisplayName(name);
      
      // Reload user to get updated profile
      await result.user?.reload();
      _user = _auth.currentUser;
      
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    }
  }
  
  // Email & Password Login
  Future<bool> loginWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);
      
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    }
  }
  
  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        _setLoading(false);
        return false;
      }
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in with the credential
      await _auth.signInWithCredential(credential);
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to sign in with Google: ${e.toString()}');
      return false;
    }
  }
  
  // Password Reset
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _setError(null);
      
      await _auth.sendPasswordResetEmail(email: email);
      
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    }
  }
  
  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      _setError('Error signing out: ${e.toString()}');
    }
  }
  
  // Update User Profile
  Future<bool> updateUserProfile({String? displayName, String? photoURL}) async {
    try {
      _setLoading(true);
      _setError(null);
      
      if (_user != null) {
        if (displayName != null) {
          await _user!.updateDisplayName(displayName);
        }
        
        if (photoURL != null) {
          await _user!.updatePhotoURL(photoURL);
        }
        
        await _user!.reload();
        _user = _auth.currentUser;
        
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to update profile: ${e.toString()}');
      return false;
    }
  }
  
  // Change Password
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    try {
      _setLoading(true);
      _setError(null);
      
      if (_user != null && _user!.email != null) {
        // Re-authenticate user before changing password
        AuthCredential credential = EmailAuthProvider.credential(
          email: _user!.email!,
          password: currentPassword,
        );
        
        await _user!.reauthenticateWithCredential(credential);
        await _user!.updatePassword(newPassword);
        
        _setLoading(false);
        return true;
      }
      
      _setLoading(false);
      return false;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    }
  }
  
  // Helper method to get user-friendly error messages
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'requires-recent-login':
        return 'Please log in again before retrying this operation.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
} 