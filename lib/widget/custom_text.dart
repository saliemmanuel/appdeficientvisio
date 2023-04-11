// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider/home_provider.dart';

class CustomText extends StatefulWidget {
  final String data;
  final TextAlign? textAlign;
  CustomText(this.data, {super.key, this.textAlign});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: widget.textAlign,
      widget.data,
      style: Provider.of<HomeProvider>(context, listen: false).customTextStyle,
    );
  }
}
