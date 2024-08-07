import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final double? width;
  final double? height;
  final TextStyle labelStyle;
  final Icon icon;
  final Color backGroundColor;
  final Color? borderColor;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    required this.labelStyle,
    required this.icon,
    required this.backGroundColor,
    this.borderColor,
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
            backgroundColor: WidgetStatePropertyAll(widget.backGroundColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: widget.borderColor ?? Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: widget.icon,
                ),
                Text(
                  widget.label,
                  style: widget.labelStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
