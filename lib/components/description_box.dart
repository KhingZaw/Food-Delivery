import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    var myInPrimaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.inversePrimary);
    var myPrimaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //delivery fee
          Column(
            children: [
              Text(
                "\$0.99",
                style: myInPrimaryTextStyle,
              ),
              Text(
                "Delivery fee",
                style: myPrimaryTextStyle,
              ),
            ],
          ),
          //delivery time
          Column(
            children: [
              Text(
                "15-30 min",
                style: myInPrimaryTextStyle,
              ),
              Text(
                "Delivery time",
                style: myPrimaryTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
