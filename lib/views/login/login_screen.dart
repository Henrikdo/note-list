import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_fonts/google_fonts.dart";

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _wrapper(),
    ));
  }

  Widget _wrapper() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(30, 78, 98, 1),
        Color.fromRGBO(45, 149, 142, 1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: _form(context),
    );
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

  Widget _fieldText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(text,
          style: _textStyle(
              const Color.fromRGBO(206, 229, 227, 1), 14, FontWeight.w300)),
    );
  }

  Widget _button() {
    return FilledButton(
      onPressed: () => {
        if (_formKey.currentState!.validate())
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing data')))
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

  TextStyle _textStyle(
    Color color,
    double fontSize,
    FontWeight fw,
  ) {
    return GoogleFonts.ptSans(fontSize: fontSize, color: color, fontWeight: fw);
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
                focusedErrorBorder:const OutlineInputBorder(
                    borderSide:BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
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
}

enum FieldType { password, user }
