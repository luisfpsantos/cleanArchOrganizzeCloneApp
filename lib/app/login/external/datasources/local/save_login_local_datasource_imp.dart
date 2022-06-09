import 'package:organizze_app/app/core/utils/shared_preferences_keys.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SaveLoginLocalDatasourceImp implements SaveLoginLocalDatasource {
  final Future<SharedPreferences> _sharedPreferencesInstance;

  SaveLoginLocalDatasourceImp(this._sharedPreferencesInstance);

  @override
  Future<bool> call(LoginEntity login) async {
    final sharedPreferences = await _sharedPreferencesInstance;

    String jsonString = json.encode(LoginDto(
      password: login.password,
      user: login.user.toLowerCase(),
      rememberMe: login.rememberMe,
    ).toMap());

    var result = await sharedPreferences.setString(
        SharedPreferencesKeys.loginLocalKey, jsonString);

    if (!result) {
      throw UnableToSaveLoginLocal('Unable to sabe login local');
    }

    return result;
  }
}
