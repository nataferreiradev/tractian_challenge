import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIcon;
  final void Function(String) onChange;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.prefixIcon,
    required this.onChange,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          fillColor: AppTheme.textFieldColor,
          filled: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: AppTheme.textFieldHint),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: AppTheme.textFieldHint,
            weight: 5,
            size: 20,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
        ),
      ),
    );
  }
}
