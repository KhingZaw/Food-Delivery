import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/user_screens/delivery_info.dart';
import 'package:food_delivery/screens/user_screens/home_screen.dart';
import 'package:food_delivery/services/auth/setupLocator.dart';
import 'package:food_delivery/services/auth/user_repository.dart';
import 'package:provider/provider.dart';

class DeliveryProgressScreen extends StatefulWidget {
  const DeliveryProgressScreen({super.key});

  @override
  State<DeliveryProgressScreen> createState() => _DeliveryProgressScreenState();
}

class _DeliveryProgressScreenState extends State<DeliveryProgressScreen> {
//get access to db
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  void initState() {
    super.initState();
    fetchRandomDeliveryUser();
    //if we get to this page, submit order to firestore db
    String receipt = context.read<Restaurant>().displayCardReceipt();
    _userRepository.saveOrderToData(receipt);
  }

  Map<String, dynamic>? deliveryUser;
  void fetchRandomDeliveryUser() async {
    final randomUser = await _userRepository.randomDelivery();

    if (randomUser != null) {
      setState(() {
        deliveryUser = randomUser;
      });
    } else {
      print("No delivery users found!");
    }
  }

  void onTap() async {
    final userByEmail = await _userRepository.getEmail(deliveryUser?["email"]);
    if (userByEmail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeliveryInfo(email: deliveryUser!['email']),
        ),
      );
    } else {
      print("Email is not return");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deliver in progress.."),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // To home screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: MyReceipt(),
      bottomNavigationBar: _buildButtonNavBar(context),
    );
  }

  //custom bottom Nav Bar -Message / Call delivery diver
  Widget _buildButtonNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            //profile pic of diver
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onTap,
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //delivery detail
            GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryUser?["name"] ?? "Loading...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Text(
                    "Driver",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                //message button
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                //call button
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber(
                          deliveryUser?["phone_number"]);
                    },
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
