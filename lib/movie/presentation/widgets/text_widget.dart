import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utilies/values_manger.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: AppSize.s20,
        fontWeight: FontWeight.w500,
        letterSpacing: AppSize.s0_5,
      ),
    );
  }
}
