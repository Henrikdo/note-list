import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:teladelogin/views/preferencias/user_preferences_screen.dart';
import 'package:url_launcher/link.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(30, 78, 98, 1),
        Color.fromRGBO(45, 149, 142, 1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _wrapper(),
          )),
    );
  }

  Widget _wrapper() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_form(context)]);
  }

  Widget _form(context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 30,
        ),
        _userField(),
        const SizedBox(
          height: 20,
        ),
        _passwordField(),
        const SizedBox(
          height: 30,
        ),
        _button(),
        _bottomText()
      ]),
    );
  }

  Widget _userField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldText('Usuário'),
          const SizedBox(
            height: 5,
          ),
          _field(
              const Icon(FontAwesomeIcons.userLarge,
                  size: 12, color: Color.fromRGBO(33, 40, 55, 1)),
              false,
              null,
              FieldType.user),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldText('Senha'),
          const SizedBox(
            height: 5,
          ),
          _field(
              const Icon(
                FontAwesomeIcons.lock,
                size: 16,
                color: Color.fromRGBO(33, 40, 55, 1),
              ),
              true,
              <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
              ],
              FieldType.password),
        ],
      ),
    );
  }

  Widget _button() {
    return FilledButton(
      onPressed: () => {
        if (_formKey.currentState!.validate())
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing data'))),
            Navigator.of(context).push(
              _createRoute(
                UserPreferences(),
              ),
            )
          }
      },
      style: FilledButton.styleFrom(
          backgroundColor: Color.fromRGBO(90, 190, 125, 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.11),
        child: Text('Entrar',
            style: _textStyle(const Color.fromRGBO(206, 229, 227, 1),
                MediaQuery.of(context).size.width * 0.04, FontWeight.w600)),
      ),
    );
  }

  Widget _field(Icon icon, bool obscureText,
      List<TextInputFormatter>? formatter, FieldType type) {
    return Material(
        elevation: 5,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: TextFormField(
            cursorColor: Color.fromRGBO(33, 40, 55, 1),
            maxLength: 20,
            enableSuggestions: false,
            inputFormatters: formatter,
            validator: (String? value) {
              if (value != null) {
                if (type == FieldType.password) {
                  return _passwordValidator(value);
                } else if (type == FieldType.user) {
                  return _userValidator(value);
                }
              }
              return null;
            },
            obscureText: obscureText,
            decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.0),
                ),
                focusedErrorBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0)),
                counterText: "",
                focusColor: Colors.red,
                contentPadding: EdgeInsets.all(10),
                filled: true,
                fillColor: Colors.white,
                errorStyle: TextStyle(
                  height: MediaQuery.of(context).size.width * 0.001,
                ),
                isDense: true,
                prefixIcon: icon)));
  }

  Widget _fieldText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(text,
          style: _textStyle(
              const Color.fromRGBO(206, 229, 227, 1), 14, FontWeight.w300)),
    );
  }

  Widget _bottomText() {
    return Padding(
        padding: EdgeInsets.only(top: 80),
        child: Link(
            uri: Uri.parse('https://www.google.com.br'),
            target: LinkTarget.defaultTarget,
            builder: (context, openLink) => InkWell(
                onTap: openLink,
                child: Text('Política de Privacidade',
                    style: _textStyle(Color.fromRGBO(206, 229, 227, 1), 14,
                        FontWeight.w200)))));
  }

  TextStyle _textStyle(
    Color color,
    double fontSize,
    FontWeight fw,
  ) {
    return GoogleFonts.ptSans(fontSize: fontSize, color: color, fontWeight: fw);
  }

  String? _passwordValidator(String value) {
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

  String? _userValidator(String value) {
    if (value.isNotEmpty) {
      if (value[value.length - 1] == " ") {
        return 'Ultimo caractere não pode ser espaço.';
      }
    } else if (value.isEmpty) {
      return 'Preencha o campo acima com seu usuário.';
    }
    return null;
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

enum FieldType { password, user }
