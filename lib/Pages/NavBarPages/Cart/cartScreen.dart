// ignore_for_file: file_names

import 'package:bikeshop/Constants/appColors.dart';
import 'package:bikeshop/Pages/Checkout/checkoutScreen.dart';
import 'package:bikeshop/providers/cartProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/cartItemScreen.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  dynamic stream = FirebaseFirestore.instance
      .collection("users-cart-items")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("items")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (context.watch<CartProvider>().cartItems <= 0)
          ? const SizedBox()
          : BottomAppBar(
              color: AppColors.transparent,
              elevation: 0,
              child: MaterialButton(
                textColor: AppColors.white,
                color: AppColors.kPrimaryColor,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckoutScreen(
                      stream: stream,
                    );
                  }));
                },
                child: const Text("Proceed To Checkout"),
              ),
            ),
      body: (context.watch<CartProvider>().cartItems <= 0)
          ? const Center(
              child: Text(
                "No Items in cart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : SafeArea(
              child: CartItemScreen(
                  collectionName: "users-cart-items", stream: stream),
              //  fetchData("users-cart-items", context),
            ),
    );
  }
}
