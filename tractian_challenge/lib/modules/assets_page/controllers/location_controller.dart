import 'package:tractian_challenge/modules/assets_page/models/location.dart';
import 'package:tractian_challenge/shared/utils/controller.dart';

class LocationController extends Controller<Location> {
  @override
  Location fromMap(Map<String, dynamic> map) {
    return Location.fromMap(map);
  }

  @override
  String buildJsonPath(String directory) {
    return 'assets/$directory/locations.json';
  }
}
