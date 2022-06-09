import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/external/datasources/local/get_user_local_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() async {
  late SharedPreferencesMock sharedPreferences;
  late GetUserLocalDatasource datasource;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    datasource = GetUserLocalDatasourceImp(Future.value(sharedPreferences));
  });

  test('should return LoginEntity', () async {
    when(() => sharedPreferences.getString(any()))
        .thenReturn('{"user":"luis","password":"1234","rememberMe":true}');

    var result = await datasource();

    expect(result, isA<LoginEntity>());
  });

  test('should return error LocalUserNotFound when return string is null',
      () async {
    when(() => sharedPreferences.getString(any())).thenReturn(null);

    var result = datasource.call;

    expect(result, throwsA(isA<LocalUserNotFound>()));
  });
}
