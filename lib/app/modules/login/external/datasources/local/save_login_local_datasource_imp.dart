import 'package:organizze_app/app/core/utils/shared_preferences_keys.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLoginLocalDatasourceImp implements SaveLoginLocalDatasource {
  final Future<SharedPreferences> _sharedPreferencesInstance;

  SaveLoginLocalDatasourceImp(this._sharedPreferencesInstance);

  @override
  Future<bool> call(String userID, String user, String password) async {
    final sharedPreferences = await _sharedPreferencesInstance;

    var result = await sharedPreferences.setString(
      SharedPreferencesKeys.loginLocalKey,
      '{"userID": "$userID", "user": "$user", "password": "$password"}',
    );

    if (!result) {
      throw UnableToSaveLoginLocal('Unable to sabe login local');
    }

    return result;
  }
}
