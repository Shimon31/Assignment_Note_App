import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showSnackbar(context, "Registration Successful", Colors.green);

      context.go('/login');
    } on FirebaseAuthException catch (e) {
      _showSnackbar(context, e.message ?? "Something went wrong", Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _showSnackbar(context, "Login Successful", Colors.green);

      context.go('/home');
    } on FirebaseAuthException catch (e) {
      _showSnackbar(context, e.message ?? "Something went wrong", Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    context.go('/login');
  }
}
