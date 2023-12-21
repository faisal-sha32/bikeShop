// ignore_for_file: file_names

import 'package:bikeshop/Constants/appColors.dart';
import 'package:bikeshop/Pages/NavBarPages/Cart/cartScreen.dart';
import 'package:bikeshop/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../NavBarPages/Home/homeScreen.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    Home(),
    const Cart(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        title: const Text(
          "Bike Shop",
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.kPrimaryColor,
        backgroundColor: AppColors.white,
        unselectedItemColor: AppColors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: const TextStyle(
            color: AppColors.black, fontWeight: FontWeight.bold),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: context.watch<CartProvider>().cartItems != 0
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.kPrimaryColor,
                      child: Text(
                        context.watch<CartProvider>().cartItems.toString(),
                        style: const TextStyle(color: AppColors.white),
                      ),
                    )
                  : const Icon(Icons.add_shopping_cart),
              label: "Cart"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
