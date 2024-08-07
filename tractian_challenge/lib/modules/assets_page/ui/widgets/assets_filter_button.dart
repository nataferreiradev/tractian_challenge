import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/app_theme.dart';
import 'package:tractian_challenge/shared/widgets/button_factory.dart';

enum ButtonStatus {
  activated,
  deactivated,
}

class AssetsFilterButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final void Function(ButtonStatus) onPressed;
  final double? width;
  // final ButtonStatus buttonStatus;
  const AssetsFilterButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    // this.buttonStatus = ButtonStatus.deactivated,
    this.width,
  });

  @override
  State<AssetsFilterButton> createState() => _AssetsFilterButtonState();
}

class _AssetsFilterButtonState extends State<AssetsFilterButton> {
  ButtonStatus buttonStatus = ButtonStatus.deactivated;

  void switchStatus() {
    buttonStatus = buttonStatus == ButtonStatus.activated
        ? ButtonStatus.deactivated
        : ButtonStatus.activated;
  }

  Color backGoundStatusColor() {
    return buttonStatus == ButtonStatus.activated
        ? AppTheme.secondColor
        : Colors.transparent;
  }

  Color borderStatusColor() {
    return buttonStatus == ButtonStatus.activated
        ? Colors.transparent
        : Colors.grey;
  }

  TextStyle labelStatusColor() {
    return TextStyle(
      color: buttonStatus == ButtonStatus.activated
          ? AppTheme.labelColor
          : Colors.grey,
    );
  }

  Color iconStatusColor() {
    return buttonStatus == ButtonStatus.activated
        ? AppTheme.labelColor
        : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonFactory.filtterButton(
      context,
      label: widget.label,
      width: widget.width,
      onPressed: () {
        switchStatus();
        setState(() {});
        widget.onPressed.call(buttonStatus);
      },
      icon: Icon(
        widget.iconData,
        color: iconStatusColor(),
      ),
      backGroundColor: backGoundStatusColor(),
      labelStyle: labelStatusColor(),
      borderColor: borderStatusColor(),
    );
  }
}
