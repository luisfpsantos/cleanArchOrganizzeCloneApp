import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/verify_login_datasource.dart';

class VerifyLoginDatasourceImp implements VerifyLoginDatasource {
  final CollectionReference _users;

  VerifyLoginDatasourceImp(this._users);

  @override
  Future<bool> call(String user, String password) async {
    var result =
        await _users.where('user', isEqualTo: user.toLowerCase()).get();

    if (result.docs.isEmpty) {
      throw UserOrPasswordInvalid('user not found');
    }

    if (result.docs[0].get('password') != password) {
      throw UserOrPasswordInvalid('invalid password');
    }

    return true;
  }
}
