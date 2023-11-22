import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future? login(TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      return result;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }
}
