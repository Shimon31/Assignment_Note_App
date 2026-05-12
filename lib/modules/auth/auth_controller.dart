import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

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

      Get.snackbar(
        "Success",
        "Registration Successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      context.go('/login');

    } on FirebaseAuthException catch (e) {

      Get.snackbar(
        "Error",
        e.message ?? "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

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

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "Login Successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      context.go('/home');

    } on FirebaseAuthException catch (e) {

      Get.snackbar(
        "Error",
        e.message ?? "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    } finally {

      isLoading.value = false;
    }
  }


  Future<void> logout(BuildContext context) async {

    await _auth.signOut();

    context.go('/login');
  }
}