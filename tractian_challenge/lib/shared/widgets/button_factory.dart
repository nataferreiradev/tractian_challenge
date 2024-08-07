import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tractian_challenge/shared/app_theme.dart';
import 'package:tractian_challenge/shared/widgets/button.dart';

abstract class ButtonFactory {
  static Widget menuButton(
    BuildContext context, {
    required String label,
    required void Function() onPressed,
    required Icon icon,
  }) {
    return Button(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 76,
      label: label,
      onPressed: onPressed,
      icon: icon,
      backGroundColor: AppTheme.secondColor,
      labelStyle: const TextStyle(color: AppTheme.labelColor, fontSize: 18),
    );
  }

  static Widget filtterButton(
    BuildContext context, {
    required String label,
    required void Function() onPressed,
    required Icon icon,
    required Color backGroundColor,
    required TextStyle labelStyle,
    required Color borderColor,
    double? width,
  }) {
    return Button(
      width: width,
      label: label,
      onPressed: onPressed,
      icon: icon,
      labelStyle: labelStyle,
      backGroundColor: backGroundColor,
      borderColor: borderColor,
    );
  }
}
