import 'package:flutter/material.dart';

class UserPreferences extends StatelessWidget {
  const UserPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color.fromRGBO(30, 78, 98, 1),
              Color.fromRGBO(45, 149, 142, 1)
            ],
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: _wrapper()),
        ));
  }

  Widget _wrapper() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _textsBox()
      ],
    );
  }

  
  Widget _textsBox() {
    return ClipRRect(
    borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white),
        width: 200,
        height: 500,
        alignment: Alignment.center,
      ),
    );
  }
}
