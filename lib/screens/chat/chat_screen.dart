import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/screens/chat/chat_bubble.dart';
import 'package:food_delivery/services/notification/noti_service.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';

class ChatScreen extends StatefulWidget {
  final String email;
  final String receiverID;
  final String name;
  ChatScreen(
      {super.key,
      required this.email,
      required this.receiverID,
      required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //text controller
  final TextEditingController _messageController = TextEditingController();
  final UserRepository _userRepository = locator<UserRepository>();

//for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add listener fo focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //cause a delay so that the keyboard  has time to show up
        //then the amount  of remaining space will be calculated
        //then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    //wait a bit for list view to be built, then scroll to bottom
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

//scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send message
      await _userRepository.sendMessage(
          widget.receiverID, _messageController.text);
      // Show notification after sending a message
      NotiService().showNotification(
        title: "New Message",
        body: _messageController.text,
      );
      //clear text controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildMessageInput(context),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String? senderID = _userRepository.getCurrentUserUID();
    return StreamBuilder(
        stream: _userRepository.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          //return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser =
        data['senderID'] == _userRepository.getCurrentUserUID();

    //align massage to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: myFocusNode,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    // Rounded corners
                  ),
                  hintText: "Try a message",
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
