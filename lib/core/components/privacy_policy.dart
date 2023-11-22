import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse('https://www.google.com.br'),
      target: LinkTarget.defaultTarget,
      builder: (context, openLink) => InkWell(
        onTap: openLink,
        child: Text(
          'Política de Privacidade',
          style: GoogleFonts.ptSans(
              fontSize: 14,
              color: const Color.fromRGBO(206, 229, 227, 1),
              fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
