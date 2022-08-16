import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const PrimaryButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.black,
      disabledColor: Colors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12.5),
      child: Text(title, style: MyTextStyles.button),
    );
  }
}
