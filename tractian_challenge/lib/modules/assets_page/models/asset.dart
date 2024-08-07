import 'package:tractian_challenge/shared/utils/model.dart';

class Asset extends Model {
  String id;
  String name;
  String? locationId;
  String? parentId;
  String? sensorType;
  String? status;

  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String locationIdKey = 'locationId';
  static const String parentIdKey = 'parentId';
  static const String sensorTypeKey = 'sensorType';
  static const String statusKey = 'status';

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
  });

  static Asset fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map[idKey],
      name: map[nameKey],
      locationId: map[locationIdKey],
      parentId: map[parentIdKey],
      sensorType: map[sensorTypeKey],
      status: map[statusKey],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      locationIdKey: locationId,
      parentIdKey: parentId,
      sensorTypeKey: sensorType,
      statusKey: status
    };
  }

  @override
  String toString() {
    return name;
  }
}
