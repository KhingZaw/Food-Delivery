import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of firebase auth
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);
  //get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //sing up
  Future<UserCredential?> signUpWithEmailPassword(
      String email, password) async {
    // try sing user up
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception("Auth error: ${e.code}");
    }
  }

  //sing in
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sing out
  Future<void> singOut() async {
    return await _firebaseAuth.signOut();
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> saveUserData(String uid, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection("users").doc(uid).set(userData);
    } catch (e) {
      throw Exception("Firestore error: $e");
    }
  }

  //get firebase store users
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        final role = doc.data()?['role'];

        // Check if the role is valid
        if (role == 'User' || role == 'Delivery') {
          return role; // Return the valid role
        } else {
          throw Exception("Invalid role found: $role"); // Unexpected role
        }
      } else {
        throw Exception("User document does not exist for uid: $uid");
      }
    } catch (e) {
      print('Error fetching user role: $e');
      throw Exception("Failed to fetch user role");
    }
  }
}
