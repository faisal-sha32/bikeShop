import 'package:bikeshop/Components/alertDialog.dart';
import 'package:bikeshop/Constants/appColors.dart';
import 'package:bikeshop/Pages/ProductDetails/productDetailScreen.dart';
import 'package:bikeshop/Service/authService.dart';
import 'package:bikeshop/Service/firebaseServiceMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    FirebaseServiceManager()
        .setCartNumber(collectionName: "users-cart-items", context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            showAlertDialog(
                context: context,
                onConfirm: () {
                  AuthService().signOut();

                  Fluttertoast.showToast(msg: "Logging out please wait..");

                  Navigator.pop(context);
                },
                dialogMessage: "Are you sure to logout ?");
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetails(
                          product: _products[index],
                        ),
                      ),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 2,
                            child: Container(
                              color: AppColors.black,
                              child: Image.network(
                                _products[index]["product-img"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${_products[index]["product-name"]}",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "\u{20B9}${_products[index]["product-price"]}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
