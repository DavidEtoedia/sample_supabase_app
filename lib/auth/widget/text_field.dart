import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput({
    Key? key,
    required this.controller,
    this.autovalidateMode,
    required this.validator,
    this.labelText,
    this.focusNode,
    this.inputFormatter,
    required this.obscureText,
    this.onEditingComplete,
    this.suffixIcon,
    this.prefixIcon,
    required this.capitalization,
  }) : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextCapitalization capitalization;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorColor: Colors.blue,
        focusNode: focusNode,
        inputFormatters: inputFormatter,
        textCapitalization: capitalization,
        autovalidateMode: autovalidateMode,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent.shade100),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,
            labelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            border: const OutlineInputBorder(borderSide: BorderSide())),
        validator: validator);
  }
}
