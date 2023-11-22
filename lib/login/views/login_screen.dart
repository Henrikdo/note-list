import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:teladelogin/core/components/export_components.dart';
import 'package:teladelogin/core/components/custom_field.dart';
import 'package:teladelogin/notes/views/user_preferences_screen.dart';
import 'package:url_launcher/link.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25,),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userField(context),
            _passwordField(context),
            _primaryButton(context),
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: PrivacyPolicy(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userField(context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1),
      child: CustomTextField(
        prefixIcon: const Icon(
          FontAwesomeIcons.userLarge,
          size: 16,
          color: Color.fromRGBO(25, 25, 26, 1),
        ),
        validator: (value) {
          if (value != null) {
            if (value.isNotEmpty) {
              if (value[value.length - 1] == " ") {
                return 'Ultimo caractere é um espaço.';
              }
            } else if (value.isEmpty) {
              return 'Preencha o campo acima com seu usuário.';
            }
            return null;
          }
        },
        headerText: 'Usuário',
      ),
    );
  }

  Widget _passwordField(context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 30,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1),
      child: CustomTextField(
        prefixIcon: const Icon(
          FontAwesomeIcons.lock,
          size: 16,
          color: Color.fromRGBO(33, 40, 55, 1),
        ),
        obscureText: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
        validator: (value) {
          if (value != null) {
            if (value.isNotEmpty) {
              if (value.length < 2) {
                return 'Senha com menos de 2 caracteres.';
              } else if (value[value.length - 1] == " ") {
                return 'Ultimo caractere é um espaço.';
              }
            } else if (value.isEmpty) {
              return 'Preencha o campo acima com sua senha.';
            }
            return null;
          }
        },
        headerText: 'Senha',
      ),
    );
  }

  Widget _primaryButton(context) {
    return FilledButton(
      onPressed: () => {
        if (_formKey.currentState!.validate())
          {
            
            Navigator.of(context).push(
              _createRoute(
                const UserPreferences(),
              ),
            ),
          },
      },
      style: FilledButton.styleFrom(
          backgroundColor: const Color.fromRGBO(90, 190, 125, 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.11),
        child: Text(
          'Entrar',
          style: GoogleFonts.ptSans(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: const Color.fromRGBO(206, 229, 227, 1),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Route _createRoute(screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
