// ignore_for_file: must_be_immutable

import 'package:chatapp_new/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.buttonLabel, this.onTap});
  final String buttonLabel;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 36,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kSecColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(buttonLabel,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)))));
  }
}
