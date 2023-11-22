import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({this.child,super.key});
  final Widget? child;
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
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
