import 'package:tractian_challenge/modules/assets_page/models/asset.dart';
import 'package:tractian_challenge/shared/utils/controller.dart';

class AssetController extends Controller<Asset> {
  @override
  String buildJsonPath(String directory) {
    return 'assets/$directory/assets.json';
  }

  @override
  Asset fromMap(Map<String, dynamic> map) {
    return Asset.fromMap(map);
  }

}
