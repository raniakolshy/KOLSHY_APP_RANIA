import 'package:flutter/material.dart';

class WhiteMenuButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final String? trailingText;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const WhiteMenuButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    this.trailingText,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: iconColor ?? Colors.black,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(color: Colors.grey),
              ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}