// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cartItems = 0;

  int get cartItems => _cartItems;

  setCartNumber(int value) {
    _cartItems = value;
    notifyListeners();
  }
}
