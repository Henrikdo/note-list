import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.validator,
    this.inputFormatters,
    this.obscureText = false,
    this.prefixIcon,
    this.headerText,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.focusNode,
  });

  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? headerText;
  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(headerText ?? '',
              style: GoogleFonts.ptSans(
                  fontSize: 14,
                  color: const Color.fromRGBO(206, 229, 227, 1),
                  fontWeight: FontWeight.w200)),
        ),
        const SizedBox(
          height: 5,
        ),
        Material(
          elevation: 5,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: TextFormField(
            focusNode: focusNode,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            onEditingComplete: onEditingComplete,
            cursorColor: Color.fromRGBO(33, 40, 55, 1),
            maxLength: 20,
            enableSuggestions: false,
            inputFormatters: inputFormatters,
            validator: validator,
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
                prefixIcon: prefixIcon,
                labelText: labelText,
                hintText: hintText),
          ),
        ),
      ],
    );
  }
}
