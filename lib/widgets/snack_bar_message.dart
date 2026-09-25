import 'package:flutter/material.dart';

void showMessage(
  BuildContext context, {
  required String text,
  Color background = Colors.red,
  Color foreground = Colors.white,
  IconData icon = Icons.error_outline,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foreground),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
      ),
    );
}