import 'package:flutter/material.dart';

import '../../../core/utilies/appStrings.dart';


class MyFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController controller;
  final void Function(String)? onChange;

  const MyFormField({
    Key? key,
    this.suffixIcon,
    this.onChange,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: AppStrings.search,
        suffixIcon: suffixIcon,
        // The rest is handled by the theme
      ),
    );
  }
}