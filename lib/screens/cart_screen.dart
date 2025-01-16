import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_cart_tile.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/components/button_widget.dart';
import 'package:food_delivery/screens/payment_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //cart
        final userCart = restaurant.cart;
        //scaffold
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              //clean cart the button
              userCart.isEmpty
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Cart is empty..",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              //cancel button
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Are you sure you want to clean the carts?",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              //cancel button
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                              //yes button
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  restaurant.clearCart();
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
            ],
          ),
          body: Column(
            children: [
              // list of cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text("Cart is empty.."),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                //get individual cart item
                                final cartItem = userCart[index];

                                //return cart tile UI
                                return MyCartTile(cartItem: cartItem);
                              },
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //button to pay
              ButtonWidget(
                onTap: () {
                  userCart.isEmpty
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Order is empty..",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              //cancel button
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                },
                text: 'Go to checkOut',
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
