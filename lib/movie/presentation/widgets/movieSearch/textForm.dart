import 'package:flutter/material.dart';

import '../../../../core/utilies/appStrings.dart';
import '../../../../core/utilies/colors.dart';

class TextFormFiled extends StatelessWidget {
  final Function(String)? onSubmit;
  final Widget? suffixIcon;


  final TextEditingController controller;
  const TextFormFiled({Key? key,required this.controller,  this.onSubmit, this.suffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      onFieldSubmitted: onSubmit,
        controller: controller,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.noSearch;
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            hintStyle:  const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.grey
            ),
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.grey
            ),
            suffixIcon: suffixIcon,
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey,),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.blue,),

            )
        )
    );
  }
}
