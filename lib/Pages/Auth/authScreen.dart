// ignore_for_file: file_names

import 'package:bikeshop/Pages/BottomNavBar/bottomNavBar.dart';
import 'package:bikeshop/Pages/Splash/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return const BottomNavController();

            // user is NOT logged in
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
