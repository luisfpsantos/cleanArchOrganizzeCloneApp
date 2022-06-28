import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/external/datasources/local/get_user_local_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() async {
  late SharedPreferences sharedPreferences;
  late GetUserLocalDatasource datasource;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    datasource = GetUserLocalDatasourceImp(Future.value(sharedPreferences));
  });

  test('should return LoginEntity', () async {
    when(() => sharedPreferences.getString(any())).thenReturn(
        '{"userID": "userID", "user": "user", "password": "password"}');

    var result = await datasource();

    expect(result, isA<String>());
  });

  test('should return error LocalUserNotFound when return string is null',
      () async {
    when(() => sharedPreferences.getString(any())).thenReturn(null);

    var result = datasource();

    expect(result, throwsA(isA<LocalUserNotFound>()));
  });
}
