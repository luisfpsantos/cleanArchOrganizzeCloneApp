import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/local/get_list_icons_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';

class RootAssetMock extends Mock implements AssetBundle {}

void main() {
  late GetListIconsDatasource getListIconsDatasource;
  late AssetBundle rootAsset;

  setUp(() {
    rootAsset = RootAssetMock();
    getListIconsDatasource = GetListIconsDatasourceImp(rootAsset);
  });

  testWidgets('should return list of string assets', (_) async {
    when(() => rootAsset.loadString(any())).thenAnswer(
      (_) async => '{"assets/images/": "assets/images/icon.png"}',
    );

    final result = await getListIconsDatasource('assets/images/');

    expect(result, isA<List<String>>());
  });

  testWidgets('should return no asset found when not found any', (_) async {
    when(() => rootAsset.loadString(any())).thenAnswer(
      (_) async => '{"assets/images/": "assets/images/icon.png"}',
    );

    final result = getListIconsDatasource('assets/teste/');

    expect(result, throwsA(isA<NoAssetsFound>()));
  });
}
