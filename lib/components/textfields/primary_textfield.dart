import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final bool? isPassword;
  final int? maxLength;
  const PrimaryTextfield(
      {Key? key, this.hint, this.prefixIcon, this.isPassword, this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        maxLength: maxLength ?? 100,
        style: MyTextStyles.textfield,
        maxLines: 1,
        minLines: 1,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(horizontal: 45),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            hintText: hint ?? '',
            hintStyle: MyTextStyles.textfield.copyWith(color: Colors.grey)),
      ),
    );
  }
}
