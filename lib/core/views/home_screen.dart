import 'package:flutter/material.dart';
import 'package:teladelogin/login/enum/login_state_enum.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teladelogin/notes/views/note_screen.dart';
import 'package:teladelogin/login/views/login_screen.dart';
import 'package:teladelogin/login/controller/login_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool bool) {
        _loginController.setLoginState(LoginState.login);
      },
      child: Observer(builder: (context) {
        if (_loginController.loginState == LoginState.success) {
          return NoteScreen();
        } else {
          return LoginScreen(loginController: _loginController);
        }
      }),
    );
  }
}
