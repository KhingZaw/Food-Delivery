import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/services/database/firestore_service.dart';
import 'auth_service.dart';

class UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserRepository(this._authService, this._firestoreService);

  Future<void> signUpUser(String email, String password, String name,
      String role, String phoneNumber, File imageFile) async {
    try {
      // Sign up user
      UserCredential? userCredential =
          await _authService.signUpWithEmailPassword(email, password);

      if (userCredential != null) {
        // Upload profile image and get URL
        String imageUrl =
            await _firestoreService.convertImageToBase64(imageFile);

        // Save user data in Firestore
        await _firestoreService.saveUserData(userCredential.user!.uid, {
          'name': name.trim(),
          'email': email.trim(),
          'role': role,
          'phone_number': phoneNumber.trim(),
          'image_url': imageUrl,
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

  //save order to db
  Future<void> saveOrderToData(String receipt) async {
    await _firestoreService.saveOrderToDatabase(receipt);
  }

  Future<Map<String, dynamic>?> randomDelivery() async {
    try {
      return await _firestoreService.getRandomDelivery();
    } catch (e) {
      throw Exception("Failed to get delivery random: $e");
    }
  }

  Future<Map<String, dynamic>?> getEmail(String email) async {
    return await _firestoreService.getUserByEmail(email);
  }

  //get current user data
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
