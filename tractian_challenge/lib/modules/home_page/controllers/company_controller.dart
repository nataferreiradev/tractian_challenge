import 'package:tractian_challenge/modules/home_page/models/company.dart';
import 'package:tractian_challenge/shared/utils/controller.dart';

class CompanyController extends Controller<Company> {
  List<Company> getListCompanies() {
    return <Company>[
      Company(id: 0, name: 'Jaguar Unit'),
      Company(id: 1, name: 'Tobias Unit'),
      Company(id: 2, name: 'Apex Unit'),
    ];
  }

  static const Map<int, String> _assetsDirectory = {
    0: 'JaguarUnit',
    1: 'TobiasUnit',
    2: 'ApexUnit',
  };

  static String getCompanyDirectory(Company company) {
    final String? directoryName = _assetsDirectory[company.id];
    if (directoryName == null || directoryName.isEmpty) throw EmptyDirectory();
    return directoryName;
  }

  @override
  String buildJsonPath(String directory) {
    throw UnimplementedError();
  }

  @override
  Company fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}

class EmptyDirectory implements Exception {
  @override
  String toString() {
    return "Could not recover directory because it's not defined";
  }
}
