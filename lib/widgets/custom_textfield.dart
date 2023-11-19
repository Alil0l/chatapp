// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomeFormTextField extends StatelessWidget {
  CustomeFormTextField(
      {super.key,
      this.hintText,
      this.action,
      this.onChanged,
      required this.hidden});
  String? hintText;
  dynamic action;
  bool hidden;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Requierd Field';
        }
        return null;
      },
      obscureText: hidden,
      onChanged: onChanged,
      textInputAction: action,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'pacifico',
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
