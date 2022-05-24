import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/login/external/datasources/local/save_login_local_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/dtos/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final datasource = SaveLoginLocalDatasourceImp(sharedPreferences);

  test('should return true user save locally', () async {
    var login =
        LoginDto(user: 'testUser', password: 'blabla', rememberMe: false);

    var result = await datasource(login);

    expect(result, true);
  });

  test('should throw error UnabeToSaveUserLocal', () async {
    final sharedPreferences = SharedPreferencesMock();
    final datasource = SaveLoginLocalDatasourceImp(sharedPreferences);

    when(() => sharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => false);

    var login =
        LoginDto(user: 'testUser', password: 'blabla', rememberMe: false);

    expect(() async => await datasource(login),
        throwsA(isA<UnableToSaveLoginLocal>()));
  });
}
