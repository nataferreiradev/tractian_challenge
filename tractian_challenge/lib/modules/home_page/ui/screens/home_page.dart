import 'package:flutter/material.dart';
import 'package:tractian_challenge/modules/home_page/controllers/company_controller.dart';
import 'package:tractian_challenge/modules/home_page/models/company.dart';
import 'package:tractian_challenge/modules/home_page/ui/widgets/home_page_buttons.dart';
import 'package:tractian_challenge/shared/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CompanyController companyController = CompanyController();

  late List<Company> listCompanies;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    setState(() => isLoading = true);
    listCompanies = companyController.getListCompanies();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        title: const Text(
          'Tractian',
          style: TextStyle(
            color: AppTheme.appBarTittle,
            fontSize: 28,
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: listCompanies.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 30),
              child: HomePageButtons.companyButton(
                context,
                listCompanies[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
