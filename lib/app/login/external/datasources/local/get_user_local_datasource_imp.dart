import 'dart:convert';
import 'package:organizze_app/app/core/utils/shared_preferences_keys.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserLocalDatasourceImp implements GetUserLocalDatasource {
  final Future<SharedPreferences> _sharedPreferencesInstance;

  GetUserLocalDatasourceImp(this._sharedPreferencesInstance);

  @override
  Future<LoginEntity> call() async {
    final sharedPreferences = await _sharedPreferencesInstance;

    final result =
        sharedPreferences.getString(SharedPreferencesKeys.loginLocalKey);

    if (result == null) {
      throw LocalUserNotFound('local user not found');
    }

    return LoginDto.fromMap(json.decode(result));
  }
}
