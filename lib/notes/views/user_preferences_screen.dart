import 'package:flutter/material.dart';
import 'package:teladelogin/core/components/export_components.dart';

class UserPreferences extends StatelessWidget {
  const UserPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(child: _body(context)),
    ));
  }

  Widget _body(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        top: MediaQuery.of(context).size.height * 0.15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          CustomTextField(
            hintText: 'Digite seu texto.',
            onChanged: (value) {},
            onEditingComplete: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Center(child: PrivacyPolicy()),
          ),
        ],
      ),
    );
  }
}
