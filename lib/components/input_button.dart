import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';

class InputButton extends StatelessWidget {
  const InputButton(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.obscureText});

  final String hintText;
  final void Function(String)? onChanged;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        decoration: kTextFieldDecoration.copyWith(hintText: hintText));
  }
}
