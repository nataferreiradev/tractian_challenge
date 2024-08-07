import 'package:flutter/material.dart';
import 'package:tractian_challenge/modules/assets_page/ui/screens/assets_page.dart';
import 'package:tractian_challenge/modules/home_page/models/company.dart';
import 'package:tractian_challenge/shared/app_theme.dart';
import 'package:tractian_challenge/shared/widgets/button_factory.dart';

abstract class HomePageButtons {
  static Widget companyButton(BuildContext context, final Company company) {
    return ButtonFactory.menuButton(
      context,
      label: company.name,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssetsPage(company: company),
          ),
        );
      },
      icon: const Icon(
        Icons.factory,
        color: AppTheme.labelColor,
      ),
    );
  }
}
