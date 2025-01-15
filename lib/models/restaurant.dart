import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';

class Restaurant extends ChangeNotifier {
  //list of food menu
  final List<Food> _menu = [
    //burger
    Food(
        name: "Classic CheeseBurger",
        description:
            "A juicy beef patty with melted cheddar, lettuce ,tomato ,and a hint of onion and pickle.",
        imagePath: "assets/images/burgers/onion_rings_side.jpg",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    Food(
        name: "BBQ Bacon Burger",
        description:
            "A juicy beef patty with melted cheddar, lettuce ,tomato ,and a hint of onion and pickle.",
        imagePath: "assets/images/burgers/loadedFries_side.jpg",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Grilled Onions", price: 0.99),
          Addon(name: "Jalapenos", price: 1.49),
          Addon(name: "Extra BBQ Sauce", price: 1.99),
        ]),
    Food(
        name: "Garlic Burger",
        description:
            "A juicy beef patty with melted cheddar, lettuce ,tomato ,and a hint of onion and pickle.",
        imagePath: "assets/images/burgers/garlic_bread_side.jpg",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    Food(
        name: "Mac Burger",
        description:
            "A juicy beef patty with melted cheddar, lettuce ,tomato ,and a hint of onion and pickle.",
        imagePath: "assets/images/burgers/mac_side.jpg",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Grilled Onions", price: 0.99),
          Addon(name: "Jalapenos", price: 1.49),
          Addon(name: "Extra BBQ Sauce", price: 1.99),
        ]),
    Food(
        name: "Sweet Potato Burger",
        description:
            "A juicy beef patty with melted cheddar, lettuce ,tomato ,and a hint of onion and pickle.",
        imagePath: "assets/images/burgers/sweet_potato_side.jpg",
        price: 0.99,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]),
    //desserts
    Food(
        name: "Cheesecake",
        description:
            "Creamy cheesecake on a graham cracker crust, with a berry compote.",
        imagePath: "assets/images/desserts/download.jpg",
        price: 0.99,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Strawberry Topping", price: 0.99),
          Addon(name: "Blueberry Compote", price: 1.99),
          Addon(name: "Chocolate Chips", price: 2.99),
        ]),
    Food(
        name: "Apple Pie",
        description:
            "Creamy cheesecake on a graham cracker crust, with a berry compote.",
        imagePath: "assets/images/desserts/download(1).jpg",
        price: 0.99,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Strawberry Topping", price: 0.99),
          Addon(name: "Blueberry Compote", price: 1.99),
          Addon(name: "Chocolate Chips", price: 2.99),
        ]),
    Food(
        name: "Red Velvet Lava Cake",
        description:
            "Creamy cheesecake on a graham cracker crust, with a berry compote.",
        imagePath: "assets/images/desserts/download(2).jpg",
        price: 0.99,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Strawberry Topping", price: 0.99),
          Addon(name: "Blueberry Compote", price: 1.99),
          Addon(name: "Chocolate Chips", price: 2.99),
        ]),
    Food(
        name: "Apple cake",
        description:
            "Creamy cheesecake on a graham cracker crust, with a berry compote.",
        imagePath: "assets/images/desserts/download(3).jpg",
        price: 0.99,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Strawberry Topping", price: 0.99),
          Addon(name: "Blueberry Compote", price: 1.99),
          Addon(name: "Chocolate Chips", price: 2.99),
        ]),
    Food(
        name: "chocolate Brownie",
        description:
            "Creamy cheesecake on a graham cracker crust, with a berry compote.",
        imagePath: "assets/images/desserts/download(4).jpg",
        price: 0.99,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Strawberry Topping", price: 0.99),
          Addon(name: "Blueberry Compote", price: 1.99),
          Addon(name: "Chocolate Chips", price: 2.99),
        ]),

    //drinks
    Food(
        name: "Lemonade",
        description:
            "Refreshing lemonade made with real lemons and a touch of sweetness.",
        imagePath: "assets/images/drinks/download.jpg",
        price: 2.99,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Strawberry Flavor", price: 0.99),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 2.99),
        ]),
    Food(
        name: "Iced Tea",
        description:
            "Refreshing lemonade made with real lemons and a touch of sweetness.",
        imagePath: "assets/images/drinks/download(1).jpg",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Strawberry Flavor", price: 0.99),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 2.99),
        ]),
    Food(
        name: "Smoothie",
        description:
            "Refreshing lemonade made with real lemons and a touch of sweetness.",
        imagePath: "assets/images/drinks/download(2).jpg",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Strawberry Flavor", price: 0.99),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 2.99),
        ]),
    Food(
        name: "Mojito",
        description:
            "Refreshing lemonade made with real lemons and a touch of sweetness.",
        imagePath: "assets/images/drinks/download(3).jpg",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Strawberry Flavor", price: 0.49),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 2.99),
        ]),
    Food(
        name: "chocolate Brownie",
        description:
            "Refreshing lemonade made with real lemons and a touch of sweetness.",
        imagePath: "assets/images/drinks/download(4).jpg",
        price: 0.99,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Strawberry Flavor", price: 0.99),
          Addon(name: "Mint Leaves", price: 1.99),
          Addon(name: "Ginger Zest", price: 2.99),
        ]),

    //salads
    Food(
        name: "Caesar Salad",
        description:
            "Crisp romaine lettuce ,parmesan cheese ,croutons and caesar dressing.",
        imagePath: "assets/images/salads/download.jpg",
        price: 2.99,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Grilled Chicken", price: 0.99),
          Addon(name: "Anchovies", price: 1.49),
          Addon(name: "Extra Parmesan", price: 1.99),
        ]),
    Food(
        name: "Greek Salads",
        description:
            "Crisp romaine lettuce ,parmesan cheese ,croutons and caesar dressing.",
        imagePath: "assets/images/salads/download(1).jpg",
        price: 0.99,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Feta Cheese", price: 0.99),
          Addon(name: "Kalamata Olives", price: 1.49),
          Addon(name: "Grilled Shrimp", price: 1.99),
        ]),
    Food(
        name: "Caesar",
        description:
            "Crisp romaine lettuce ,parmesan cheese ,croutons and caesar dressing.",
        imagePath: "assets/images/salads/download(2).jpg",
        price: 0.99,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Grilled Chicken", price: 0.99),
          Addon(name: "Anchovies", price: 1.49),
          Addon(name: "Extra Parmesan", price: 1.99),
        ]),
    Food(
        name: "Greek",
        description:
            "Crisp romaine lettuce ,parmesan cheese ,croutons and caesar dressing.",
        imagePath: "assets/images/salads/download(3).jpg",
        price: 0.99,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Feta Cheese", price: 0.99),
          Addon(name: "Kalamata Olives", price: 1.49),
          Addon(name: "Grilled Shrimp", price: 1.99),
        ]),
    Food(
        name: "Salad",
        description:
            "Crisp romaine lettuce ,parmesan cheese ,croutons and caesar dressing.",
        imagePath: "assets/images/salads/download(4).jpg",
        price: 0.99,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Grilled Chicken", price: 0.99),
          Addon(name: "Anchovies", price: 1.49),
          Addon(name: "Extra Parmesan", price: 1.99),
        ]),

    //sides
    Food(
        name: "Sweet Potato Fries",
        description: "Crispy sweet potato fries with a touch of salt.",
        imagePath: "assets/images/sides/download.jpg",
        price: 2.99,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Cheese Sauce", price: 0.99),
          Addon(name: "Truffle Oil", price: 1.49),
          Addon(name: "Cajun Spice", price: 1.99),
        ]),
    Food(
        name: "Onion Rings",
        description: "Golden and crispy onion rings, perfect for dipping.",
        imagePath: "assets/images/sides/download(1).jpg",
        price: 0.99,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Ranch Dip", price: 0.99),
          Addon(name: "Spicy Mayo", price: 1.49),
          Addon(name: "Parmesan Dust", price: 1.99),
        ]),
    Food(
        name: "Sweet Potato",
        description: "Crispy sweet potato fries with a touch of salt.",
        imagePath: "assets/images/sides/download(2).jpg",
        price: 2.99,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Cheese Sauce", price: 0.99),
          Addon(name: "Truffle Oil", price: 1.49),
          Addon(name: "Cajun Spice", price: 1.99),
        ]),
    Food(
        name: "Onion",
        description: "Golden and crispy onion rings, perfect for dipping.",
        imagePath: "assets/images/sides/download(3).jpg",
        price: 0.99,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Ranch Dip", price: 0.99),
          Addon(name: "Spicy Mayo", price: 1.49),
          Addon(name: "Parmesan Dust", price: 1.99),
        ]),
    Food(
        name: "Sweet",
        description: "Crispy sweet potato fries with a touch of salt.",
        imagePath: "assets/images/sides/download(4).jpg",
        price: 2.99,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Cheese Sauce", price: 0.99),
          Addon(name: "Truffle Oil", price: 1.49),
          Addon(name: "Cajun Spice", price: 1.99),
        ]),
  ];

  /*

  G E T T E R S

  */
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  /*

  O P E R A T I O N S

  */
  // user cart
  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull(
      (item) {
        //check if the food items are the same
        bool isSameFood = item.food == food;

        //check if the list of selected addons are the same
        bool isSameAddons =
            ListEquality().equals(item.selectedAddons, selectedAddons);
        return isSameFood && isSameAddons;
      },
    );
    //if items already exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    //otherwise,add a new cart item to the cart
    else {
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

  // remove from
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // get total number of item in cart
  int getTotalCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  /*

  H E L P E R S

  */

  // generation a receipt

  // format double value into money

  // format list of addons into a string summary
}
