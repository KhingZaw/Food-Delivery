import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/message.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore;
  ChatService(this._firestore);

  //send message
  Future<void> sendMessage(String chatRoomID, Message newMessage) async {
    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String chatRoomID) {
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
