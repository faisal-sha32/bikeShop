// ignore: file_names
import 'package:bikeshop/providers/cartProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FirebaseServiceManager {
  Future<void> addToCart({
    var product,
    BuildContext? context,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance.collection(
      "users-cart-items",
    );
    return collectionRef
        .doc(
          currentUser!.email,
        )
        .collection(
          "items",
        )
        .doc()
        .set({
      "name": product["product-name"],
      "price": product["product-price"],
      "images": product["product-img"],
    }).then((value) {
      Fluttertoast.showToast(msg: "Item added to cart");
    });
  }

  Future setCartNumber({
    String? collectionName,
    BuildContext? context,
  }) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(
      collectionName!,
    );

    QuerySnapshot querySnapshot = await collection
        .doc(
          FirebaseAuth.instance.currentUser!.email,
        )
        .collection(
          "items",
        )
        .get();

    // ignore: use_build_context_synchronously
    Provider.of<CartProvider>(context!, listen: false).setCartNumber(
      querySnapshot.docs.length.toInt(),
    );
  }

  Future<void> removeItemFromCart({
    String? collectionName,
    String? documentId,
    BuildContext? context,
  }) async {
    FirebaseFirestore.instance
        .collection(
          collectionName!,
        )
        .doc(
          FirebaseAuth.instance.currentUser!.email,
        )
        .collection(
          "items",
        )
        .doc(
          documentId,
        )
        .delete()
        .then((_) {});
  }

  Future<void> clearCart(
    String collectionPath,
    String documentId,
    String subcollectionPath,
    BuildContext? context,
  ) async {
    // Get a reference to the subcollection
    CollectionReference subcollectionReference = FirebaseFirestore.instance
        .collection(
          collectionPath,
        )
        .doc(
          documentId,
        )
        .collection(
          subcollectionPath,
        );

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await subcollectionReference.get();

    // Delete each document in the subcollection
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await subcollectionReference.doc(documentSnapshot.id).delete();
    }

    // ignore: use_build_context_synchronously
    Provider.of<CartProvider>(context!, listen: false).setCartNumber(0);
  }
}
