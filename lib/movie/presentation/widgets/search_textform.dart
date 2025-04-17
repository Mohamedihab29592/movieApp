import 'package:flutter/material.dart';
import '../../../core/utilies/assets.dart';
import '../../../core/utilies/strings.dart';


class MyFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController controller;
  final VoidCallback? onClear;
  final VoidCallback? onSearch;
  final FormFieldValidator<String>? validator;

  const MyFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onClear,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final hasText = value.text.isNotEmpty;

        return TextFormField(
          validator: validator ??
                  (value) {
                if ((value == null || value.isEmpty) ) {
                  return AppStrings.errorSearch;
                }
                return null;
              },
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: AppStrings.search,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasText)
                  IconButton(
                    onPressed: () {
                      controller.clear();
                      if (onClear != null) onClear!();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                IconButton(
                  onPressed: () {
                    if (onSearch != null) onSearch!();

                  },
                  icon: const ImageIcon(AssetImage(Assets.searchIconRe)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}