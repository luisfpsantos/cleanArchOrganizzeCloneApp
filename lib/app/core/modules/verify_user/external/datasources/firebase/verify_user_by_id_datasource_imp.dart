import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/errors/verify_user_by_id_erros.dart';
import 'package:organizze_app/app/core/modules/verify_user/infra/datasources/verify_user_by_id_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class VerifyUserByIdDatasourceImp implements VerifyUserByIdDatasource {
  final FirebaseFirestore _firebaseFirestore;

  VerifyUserByIdDatasourceImp(this._firebaseFirestore);

  @override
  Future<Map> call(String id) async {
    final user = _firebaseFirestore.doc('${FirebaseCollections.users}/$id');

    var result = await user.get();

    if (result.exists) {
      throw UserNotFound('user not found');
    }

    if (result.data() == null) {
      throw UserNotFound('user not found');
    }

    return result.data()!;
  }
}
