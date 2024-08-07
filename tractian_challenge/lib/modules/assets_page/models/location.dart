import 'package:tractian_challenge/shared/utils/model.dart';

class Location extends Model {
  String id;
  String name;
  String? parentId;

  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String parentIdKey = 'parentId';

  Location({
    required this.id,
    required this.name,
    this.parentId,
  });

  static Location fromMap(Map<String, dynamic> map) {
    return Location(
      id: map[idKey],
      name: map[nameKey],
      parentId: map[parentIdKey],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      parentIdKey: parentId,
    };
  }

  @override
  String toString() {
    return name;
  }
}
