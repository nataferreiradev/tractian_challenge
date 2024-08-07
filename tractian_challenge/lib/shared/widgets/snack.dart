import 'package:flutter/material.dart';

class Snack {
  final BuildContext context;

  Widget content;
  Color backgroundColor;
  Duration duration;
  Color textColor = Colors.black;

  Snack({
    required this.context,
    required this.content,
    required this.backgroundColor,
    this.duration = const Duration(seconds: 2),
  });

  show() {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.action);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: content,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ));
  }

  static void erro({
    required BuildContext context,
    required String texto,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    Snack(
      context: context,
      content: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
    ).show();
  }
}
