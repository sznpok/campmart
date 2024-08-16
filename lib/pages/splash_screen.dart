import 'dart:async';

import 'package:campmart/utils/theme.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/custom_storage.dart';
import 'bottom_nav_bar_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateScreen() async {
    String? accessToken = await readTokenAccess();
    if (accessToken != null && accessToken.isNotEmpty) {
      ApiToken.token = accessToken.toString();
    }
    if (accessToken != null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBarScreen(),
            ),
            (route) => false,
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    navigateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "CampMart",
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
      )),
    );
  }
}
