import 'package:flutter/material.dart';
import 'package:food_delivery/screens/chat/chat_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderID;
  OrderDetailScreen({super.key, required this.orderID});

  final UserRepository _userRepository = locator<UserRepository>();

  void chatTap(String customerEmail, BuildContext context) async {
    final userByEmail = await _userRepository.getUserByEmail(customerEmail);
    final currentUser =
        await _userRepository.getCurrentUserData(); // Fetch current user data

    if (userByEmail != null && userByEmail['email'] != currentUser?["email"]) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            email: userByEmail['email'],
            receiverID: userByEmail["uid"],
            name: userByEmail["name"],
          ),
        ),
      );
    } else {
      print("Email is not returned or it's the same as the current user.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userRepository.getOrderDetails(orderID), // Fetch order details
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
                child: Text(
              "No order found",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ));
          }

          final orderData = snapshot.data!;
          String customerEmail = orderData['customer_email'];

          // Fetch the user's information based on the customer email
          return FutureBuilder<Map<String, dynamic>?>(
            future: _userRepository
                .getUserByEmail(customerEmail), // Fetch user details
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (userSnapshot.hasError) {
                return Center(
                    child: Text("Error fetching user: ${userSnapshot.error}"));
              }

              final userData = userSnapshot.data;
              String customerName = userData?['name'] ??
                  'Unknown'; // Default to 'Unknown' if name is not found

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Customer Name: $customerName",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary)),
                        SizedBox(
                          width: 40,
                        ),

                        //message button
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => chatTap(customerEmail, context),
                            icon: Icon(
                              Icons.message,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        //call button
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              // FlutterPhoneDirectCaller.callNumber(
                              //     _numberCtrl.text);
                            },
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Theme.of(context).colorScheme.primary),
                    SizedBox(height: 10),
                    Center(
                      child: Text("Receipt: ${orderData['receipt']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text("Status: ${orderData['status']}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
