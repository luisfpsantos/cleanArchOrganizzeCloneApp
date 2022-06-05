import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_in_database_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/logged_user_dto.dart';

class GetUserInDatabaseDatasourceImp implements GetUserInDatabaseDatasource {
  final FirebaseFirestore _firebaseFirestore;

  GetUserInDatabaseDatasourceImp(this._firebaseFirestore);

  @override
  Future<LoggedUserEntity> call(String loggedUser) async {
    final users = _firebaseFirestore.collection(FirebaseCollections.users);

    var result =
        await users.where('user', isEqualTo: loggedUser.toLowerCase()).get();

    if (result.docs.isEmpty) {
      throw UserNotFound('user not found in database');
    }

    return LoggedUserDto.fromMap(result.docs[0].data(), result.docs[0].id);
  }
}
