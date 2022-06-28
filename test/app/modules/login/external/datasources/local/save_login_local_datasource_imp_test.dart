import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/external/datasources/local/save_login_local_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() async {
  late SharedPreferences sharedPreferences;
  late SaveLoginLocalDatasource datasource;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    datasource = SaveLoginLocalDatasourceImp(Future.value(sharedPreferences));
  });

  test('should return true user save locally', () async {
    when(() => sharedPreferences.setString(any(), any())).thenAnswer(
      (_) async => true,
    );

    var result = await datasource('id', 'user', 'password');

    expect(result, true);
  });

  test('should throw error UnabeToSaveUserLocal', () async {
    when(() => sharedPreferences.setString(any(), any())).thenAnswer(
      (_) async => false,
    );

    var result = datasource('id', 'user', 'password');

    expect(result, throwsA(isA<UnableToSaveLoginLocal>()));
  });
}
