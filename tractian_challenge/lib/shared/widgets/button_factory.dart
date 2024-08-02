import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/widgets/button.dart';

abstract class ButtonFactory {
  static menuButton(
    BuildContext context,
    String label,
    void Function() onPressed,
  ) {
    return Button(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 76,
      label: label,
      onPressed: onPressed,
    );
  }
}
