import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;

class FirestoreService {
  //get collection of orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

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

  // get random delivery
  Future<Map<String, dynamic>?> getRandomDelivery() async {
    try {
      // Query users with the role of "Delivery"
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .where("role", isEqualTo: "Delivery")
          .get();

      // Check if there are any documents
      if (querySnapshot.docs.isEmpty) {
        return null; // No users with the role "Delivery"
      }

      // Randomly pick one document
      final randomIndex = Random().nextInt(querySnapshot.docs.length);
      DocumentSnapshot randomUser = querySnapshot.docs[randomIndex];

      // Return the random user data
      return randomUser.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error fetching random delivery user: $e");
      return null;
    }
  }

  // Fetch user details based on email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null; // No user found
      }

      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error fetching user by email: $e");
      return null;
    }
  }

  // Convert Image to Base64 and Compress
  Future<String> convertImageToBase64(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 200, height: 200);
      Uint8List compressedBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 75));
      return base64Encode(compressedBytes);
    }

    return base64Encode(imageBytes);
  }

  getOrdersForDeliveryUser(String deliveryEmail) {
    return _firestore
        .collection("orders")
        .where("delivery_email", isEqualTo: deliveryEmail) // Filter orders
        .orderBy("timestamp", descending: true) // Sort latest orders first
        .get();
  }
}
