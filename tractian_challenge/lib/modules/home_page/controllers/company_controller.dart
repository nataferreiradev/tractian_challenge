import 'package:tractian_challenge/modules/home_page/models/company.dart';

class CompanyController {
  List<Company> getListCompanies() {
    return <Company>[
      Company(id: 0, name: 'Jaguar Unit'),
      Company(id: 1, name: 'Tobias Unit'),
      Company(id: 3, name: 'Apex Unit'),
    ];
  }
}
