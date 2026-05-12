import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {

    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    Timer(const Duration(seconds: 2), () {

      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (user != null) {
        context.go('/home');
      }
      else if (isFirstTime) {
        prefs.setBool('isFirstTime', false);
        context.go('/login');
      }
      else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}