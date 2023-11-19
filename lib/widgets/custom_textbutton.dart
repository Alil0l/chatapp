// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({super.key, required this.buttonLabel, this.onTap});
  final String buttonLabel;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Text(buttonLabel, style: kTextButtonStyle));
  }
}
