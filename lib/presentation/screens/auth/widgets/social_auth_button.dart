import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialAuthButton({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Image.asset(
        imagePath,
        height: 24,
      ),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
} 