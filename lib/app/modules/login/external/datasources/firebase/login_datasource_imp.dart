import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/login_datasource.dart';

class LoginDatasourceImp implements LoginDatasource {
  final FirebaseFirestore _firebaseFirestore;

  LoginDatasourceImp(this._firebaseFirestore);

  @override
  Future<Map> call(String user, String password) async {
    final users = _firebaseFirestore.collection(FirebaseCollections.users);

    var result = await users.where('user', isEqualTo: user.toLowerCase()).get();

    if (result.docs.isEmpty) {
      throw UserOrPasswordInvalid('user not found');
    }

    if (result.docs[0].get('password') != password) {
      throw UserOrPasswordInvalid('invalid password');
    }

    return {'userID': result.docs[0].id, 'user': result.docs[0].data()};
  }
}
