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
