import 'package:flutter/material.dart';
import 'package:food_delivery/components/drawer_widget.dart';
import 'package:food_delivery/screens/delivery_screens/order_detail_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final UserRepository _userRepository = locator<UserRepository>();
  List<Map<String, dynamic>> orders = [];
  String? currentUserEmail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final user =
        await _userRepository.getCurrentUserData(); // Get logged-in user
    currentUserEmail = user?["email"];

    if (currentUserEmail != null) {
      orders =
          await _userRepository.getOrdersForDeliveryUser(currentUserEmail!);
    }

    setState(() {
      isLoading = false;
    });
  }
// In your DeliveryHomeScreen

  void navigateToOrderDetail(String orderID) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderDetailScreen(orderID: orderID)),
    );
  }

  void logOut() async {
    await _userRepository.singOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Delivery"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loader while fetching
          : orders.isEmpty
              ? Center(
                  child: Text(
                  "No orders found",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: GestureDetector(
                          onTap: () => navigateToOrderDetail(order["orderID"]),
                          child: ListTile(
                            title: Text(
                              "Order for: ${order["orderID"]}",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: Text(
                              "Status: ${order["status"] ?? "Pending"}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            // trailing: Text(
                            //     order["timestamp"]?.toDate().toString() ?? ""),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
