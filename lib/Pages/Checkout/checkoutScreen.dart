import 'package:bikeshop/Constants/appColors.dart';
import 'package:bikeshop/Pages/Success/successScreen.dart';
import 'package:bikeshop/Service/firebaseServiceMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  final Stream<dynamic>? stream;
  const CheckoutScreen({super.key, required this.stream});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? userName;
  String? userEmail;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = auth.currentUser;
    final email = user!.email;

    if (mounted) {
      setState(() {
        userEmail = email;
        userName = email!.split("@")[0];
      });
    }

    // here you write the codes to input the data into firestore
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: MaterialButton(
          textColor: AppColors.white,
          color: AppColors.kPrimaryColor,
          onPressed: () async {
            FirebaseServiceManager().clearCart(
                "users-cart-items",
                FirebaseAuth.instance.currentUser!.email.toString(),
                "items",
                context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SuccessScreen();
            }));
          },
          child: const Text("PLACE ORDER"),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order Details"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name:${userName!.toUpperCase()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Email:${userEmail!.toUpperCase()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Selected Bikes:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-cart-items")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items")
                    .snapshots(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something is wrong"),
                    );
                  }

                  return ListView.separated(
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];

                      return Card(
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                documentSnapshot['images'],
                              ),
                            ),
                            Text(documentSnapshot['name']),
                            Text(
                              "  \u{20B9}${documentSnapshot['price']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
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
