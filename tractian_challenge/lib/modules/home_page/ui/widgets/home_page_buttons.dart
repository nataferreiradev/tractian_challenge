import 'package:flutter/material.dart';
import 'package:tractian_challenge/modules/home_page/models/company.dart';
import 'package:tractian_challenge/shared/widgets/button_factory.dart';

abstract class HomePageButtons {
  static Widget companyButton(BuildContext context, final Company company) {
    return ButtonFactory.menuButton(
      context,
      company.name,
      () {
        print(company.id);
      },
    );
  }
}
