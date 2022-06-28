import 'package:flutter/services.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'dart:convert';

class GetListIconsDatasourceImp implements GetListIconsDatasource {
  final AssetBundle _assetBundle;

  GetListIconsDatasourceImp(this._assetBundle);

  @override
  Future<List<String>> call(String assetPath) async {
    List<String> imagesList = [];

    final assets = await _assetBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> mapAssets = json.decode(assets);

    final List<String> filterAssets =
        mapAssets.keys.where((keys) => keys.contains(assetPath)).toList();

    if (filterAssets.isEmpty) throw NoAssetsFound('No assets found');

    for (var asset in filterAssets) {
      imagesList.add(asset);
    }

    return imagesList;
  }
}
