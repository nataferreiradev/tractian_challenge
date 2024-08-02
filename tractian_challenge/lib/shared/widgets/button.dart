import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/app_theme.dart';

class Button extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final double width;
  final double height;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  State<Button> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppTheme.secondColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.scatter_plot,
                  color: AppTheme.labelColor,
                ),
              ),
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppTheme.labelColor,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
