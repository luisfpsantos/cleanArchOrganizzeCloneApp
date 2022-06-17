import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/verify_login_datasource.dart';

class VerifyLoginDatasourceImp implements VerifyLoginDatasource {
  final FirebaseFirestore _firebaseFirestore;

  VerifyLoginDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(String user, String password) async {
    final users = _firebaseFirestore.collection(FirebaseCollections.users);

    var result = await users.where('user', isEqualTo: user.toLowerCase()).get();

    if (result.docs.isEmpty) {
      throw UserOrPasswordInvalid('user not found');
    }

    if (result.docs[0].get('password') != password) {
      throw UserOrPasswordInvalid('invalid password');
    }

    return true;
  }
}
