
import 'package:tractian_challenge/shared/utils/model.dart';

class Company extends Model {
  int id;
  String name;

  Company({
    required this.id,
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
