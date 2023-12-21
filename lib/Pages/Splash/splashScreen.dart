import 'dart:async';

import 'package:bikeshop/Constants/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Login/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLoginScreen();
    super.initState();
  }

  navigateToLoginScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => const LoginScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bike Shop",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 40.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
