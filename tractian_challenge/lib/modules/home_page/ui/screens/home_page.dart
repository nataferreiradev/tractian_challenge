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
  final ScrollController scrollController = ScrollController();

  List<Company> listCompanies = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() => isLoading = true);
    await loadCompanies();
    setState(() => isLoading = false);
  }

  loadCompanies() {
    listCompanies = companyController.getListCompanies();
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
    if (listCompanies.isEmpty) {
      return const Center(child: Text('Nenhuma compania foi encontrada'));
    }
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listCompanies.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 30),
                child: HomePageButtons.companyButton(
                  context,
                  listCompanies[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
