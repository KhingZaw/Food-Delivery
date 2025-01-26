import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserRepository(this._authService, this._firestoreService);

  Future<void> signUpUser(
      String email, String password, String name, String role) async {
    try {
      // Sign up user with email and password
      UserCredential? userCredential =
          await _authService.signUpWithEmailPassword(email, password);

      // Save additional user data in Firestore
      if (userCredential != null) {
        await _firestoreService.saveUserData(userCredential.user!.uid, {
          'name': name.trim(),
          'email': email.trim(),
          'role': role,
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception("Error during sign-up: $e");
    }
  }

  Future<String> signInAndFetchRole(String email, String password) async {
    try {
      // Sign in the user
      UserCredential userCredential =
          await _authService.signInWithEmailPassword(email, password);

      // Fetch user role
      String? role =
          await _firestoreService.getUserRole(userCredential.user!.uid);

      return role as String;
    } catch (e) {
      throw Exception("Error during sign-in or role fetching: $e");
    }
  }

  Future<String?> getUserAndRole(String uid) async {
    try {
      return await _firestoreService
          .getUserRole(uid); // Delegate to FirestoreService
    } catch (e) {
      throw Exception("Failed to get user role: $e");
    }
  }

  Future<void> singOutUser() async {
    try {
      await _authService.singOut();
    } catch (e) {
      print("Error signing out: $e");
      // Show an error message or handle the error accordingly
    }
  }
}
