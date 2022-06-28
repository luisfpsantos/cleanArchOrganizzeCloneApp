import 'package:organizze_app/app/core/utils/shared_preferences_keys.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserLocalDatasourceImp implements GetUserLocalDatasource {
  final Future<SharedPreferences> _sharedPreferencesInstance;

  GetUserLocalDatasourceImp(this._sharedPreferencesInstance);

  @override
  Future<String> call() async {
    final sharedPreferences = await _sharedPreferencesInstance;

    final result =
        sharedPreferences.getString(SharedPreferencesKeys.loginLocalKey);

    if (result == null) {
      throw LocalUserNotFound('local user not found');
    }

    return result;
  }
}
