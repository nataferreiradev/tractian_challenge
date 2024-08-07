import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/app_theme.dart';

class AppbarLeadingButton extends StatefulWidget {
  const AppbarLeadingButton({super.key});

  @override
  State<AppbarLeadingButton> createState() => _AppbarLeadingButtonState();
}

class _AppbarLeadingButtonState extends State<AppbarLeadingButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(10),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppTheme.appBarTittle,
          ),
        ),
      ),
    );
  }
}
