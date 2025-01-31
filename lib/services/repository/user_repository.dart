import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/models/message.dart';
import 'package:food_delivery/services/chats/chat_service.dart';
import 'package:food_delivery/services/database/firestore_service.dart';
import '../auth/auth_service.dart';

class UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final ChatService _chatStore;

  UserRepository(this._authService, this._firestoreService, this._chatStore);

  /// Get current user UID
  String? getCurrentUserUID() {
    return _authService.getCurrentUserUID();
  }

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
          'uid': userCredential.user!.uid,
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
      await _authService.singOutUser();
    } catch (e) {
      print("Error signing out: $e");
      // Show an error message or handle the error accordingly
    }
  }

  //save order to db
  Future<void> saveOrderToData(
      String receipt, String? customerEmail, String? deliveryEmail) async {
    try {
      final ordersCollection = FirebaseFirestore.instance.collection("orders");
      // Generate a unique order ID
      final orderID = ordersCollection.doc().id;

      await ordersCollection.doc(orderID).set({
        // Use set() to specify the ID
        "orderID": orderID, // Add orderID to the document
        "receipt": receipt,
        "customer_email": customerEmail,
        "delivery_email": deliveryEmail,
        "timestamp": FieldValue.serverTimestamp(), // Stores the order time
        "status": "pending" // Default status
      });

      print("Order saved successfully!");
    } catch (e) {
      print("Error saving order: $e");
    }
  }

  Future<Map<String, dynamic>?> randomDelivery() async {
    try {
      return await _firestoreService.getRandomDelivery();
    } catch (e) {
      throw Exception("Failed to get delivery random: $e");
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
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

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user info
    final String? currentUserID = await _authService.getCurrentUserUID();
    final String? currentUserEmail = await _authService.getCurrentUserEmail();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderID: currentUserID!,
        senderEmail: currentUserEmail!,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);
    //construct chat room Id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids (the ensure the chatroomId is the same for any 2 people)
    String chatRoomID = ids.join('_');
    //add new message to database
    await _chatStore.sendMessage(chatRoomID, newMessage);
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chatroomID for the 2 users.
    List<String> ids = [userID, otherUserID];
    ids.sort();

    String chatRoomID = ids.join('_');
    return _chatStore.getMessages(chatRoomID);
  }

  Future<List<Map<String, dynamic>>> getOrdersForDeliveryUser(
      String deliveryEmail) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("orders")
          .where("delivery_email", isEqualTo: deliveryEmail) // Filter orders
          .orderBy("timestamp", descending: true) // Sort latest orders first
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

//In user_repository.dart
  Future<Map<String, dynamic>?> getOrderDetails(String orderID) async {
    try {
      final orderDoc = await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderID)
          .get();

      if (orderDoc.exists) {
        return orderDoc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error fetching order details: $e");
    }
    return null; // Return null if the order doesn't exist
  }
}
