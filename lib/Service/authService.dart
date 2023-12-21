// ignore: file_names
import 'package:bikeshop/Pages/BottomNavBar/bottomNavBar.dart';
import 'package:bikeshop/Pages/Login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut({required BuildContext? context}) async {
    try {
      await _auth.signOut();

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context!,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
      debugPrint("User logged out");
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  Future<void> signUp(
      {BuildContext? context, String? email, String? password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      var authCredential = userCredential.user;
      debugPrint(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context!,
          CupertinoPageRoute(
            builder: (_) => const BottomNavController(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something is wrong",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
        );
      }
    } catch (_) {}
  }

  Future<void> signIn(
      {BuildContext? context, String? email, String? password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      var authCredential = userCredential.user;
      debugPrint(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context!,
          CupertinoPageRoute(
            builder: (_) => const BottomNavController(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something is wrong",
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
        );
      }
    } catch (_) {}
  }
}
