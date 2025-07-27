import 'package:flutter/material.dart';

class WhiteMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final String? trailingText;
  final Color? textColor;

  const WhiteMenuButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.trailingText,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.black87,
                ),
              ),
            ),
            if (trailingText != null)
              Text(trailingText!, style: const TextStyle(color: Colors.grey)),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
