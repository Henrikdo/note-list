import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:teladelogin/login/enum/login_state_enum.dart';
part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  LoginState loginState = LoginState.login;

  @action
  Future login(TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      setLoginState(LoginState.loading);

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      setLoginState(LoginState.success);

      return result;
    } catch (e) {
      setLoginState(LoginState.error);

      return null;
    }
  }

  @action
  void setLoginState(LoginState newState) {
    loginState = newState;
  }
}
