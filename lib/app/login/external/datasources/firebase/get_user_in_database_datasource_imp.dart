import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_in_database_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/logged_user_dto.dart';

class GetUserInDatabaseDatasourceImp implements GetUserInDatabaseDatasource {
  final CollectionReference _users;

  GetUserInDatabaseDatasourceImp(this._users);

  @override
  Future<LoggedUserEntity> call(String loggedUser) async {
    var result =
        await _users.where('user', isEqualTo: loggedUser.toLowerCase()).get();

    if (result.docs.isEmpty) {
      throw UserNotFound('user not found in database');
    }

    return LoggedUserDto.fromMap(
        result.docs[0].data() as Map<String, dynamic>, result.docs[0].id);
  }
}
