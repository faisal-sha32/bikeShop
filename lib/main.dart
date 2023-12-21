import 'package:bikeshop/Pages/Auth/authScreen.dart';
import 'package:bikeshop/firebase_options.dart';
import 'package:bikeshop/providers/cartProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(
        key: UniqueKey(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.0,
                ),
                child: AuthPage(),
              ),
            ),
          ),
        );
      },
    );
  }
}
