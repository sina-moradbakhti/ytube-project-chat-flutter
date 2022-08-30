import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final bool? isPassword;
  final int? maxLength;
  final bool multiLine;
  final Function(String)? onChanged;
  const PrimaryTextfield(
      {Key? key,
      this.hint,
      this.prefixIcon,
      this.isPassword,
      this.maxLength,
      this.onChanged,
      this.multiLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget txtfld = TextField(
      maxLength: multiLine ? 999 : (maxLength ?? 100),
      onChanged: onChanged != null ? (newValue) => onChanged!(newValue) : null,
      style: MyTextStyles.textfield,
      maxLines: multiLine ? 7 : 1,
      minLines: multiLine ? 7 : 1,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
          counterText: '',
          contentPadding: multiLine
              ? const EdgeInsets.symmetric(horizontal: 45, vertical: 20)
              : const EdgeInsets.symmetric(horizontal: 45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: hint ?? '',
          hintStyle: MyTextStyles.textfield.copyWith(color: Colors.grey)),
    );

    return multiLine
        ? txtfld
        : SizedBox(
            height: 50,
            child: txtfld,
          );
  }
}
