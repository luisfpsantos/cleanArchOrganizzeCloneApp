import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/login/external/datasources/local/save_login_local_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() async {
  late SharedPreferencesMock sharedPreferences;
  late SaveLoginLocalDatasource datasource;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    datasource = SaveLoginLocalDatasourceImp(sharedPreferences);
  });

  test('should return true user save locally', () async {
    when(() => sharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => true);

    var result = await datasource(
      LoginDto(user: 'testUser', password: 'blabla', rememberMe: false),
    );

    expect(result, true);
  });

  test('should throw error UnabeToSaveUserLocal', () async {
    when(() => sharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => false);

    var result = datasource.call;

    expect(
        result(
          LoginDto(user: 'testUser', password: 'blabla', rememberMe: false),
        ),
        throwsA(isA<UnableToSaveLoginLocal>()));
  });
}
