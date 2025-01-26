import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/user_screens/home_screen.dart';
import 'package:food_delivery/services/database/firestore_service.dart';
import 'package:provider/provider.dart';

class DeliveryProgressScreen extends StatefulWidget {
  const DeliveryProgressScreen({super.key});

  @override
  State<DeliveryProgressScreen> createState() => _DeliveryProgressScreenState();
}

class _DeliveryProgressScreenState extends State<DeliveryProgressScreen> {
//get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();
    //if we get to this page, submit order to firestore db
    String receipt = context.read<Restaurant>().displayCardReceipt();
    db.saveOrderToDatabase(receipt);
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
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //delivery detail
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mich KoKo",
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
                    onPressed: () {},
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
