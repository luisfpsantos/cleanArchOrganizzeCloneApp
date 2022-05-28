import 'dart:convert';

import 'package:organizze_app/app/core/utils/shared_preferences_keys.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLoginLocalDatasourceImp implements SaveLoginLocalDatasource {
  final SharedPreferences _sharedPreferences;

  SaveLoginLocalDatasourceImp(this._sharedPreferences);

  @override
  Future<bool> call(LoginEntity login) async {
    String jsonString = json.encode(LoginDto(
      password: login.password,
      user: login.user,
      rememberMe: login.rememberMe,
    ).toMap());

    var result = await _sharedPreferences.setString(
        SharedPreferencesKeys.loginLocalKey, jsonString);

    if (!result) {
      throw UnableToSaveLoginLocal('Unable to sabe login local');
    }

    return result;
  }
}
