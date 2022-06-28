import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_local_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/dtos/user_local_dto.dart';

class UserLocalRepositoryImp implements UserLocalRepository {
  final SaveLoginLocalDatasource _saveLoginLocalDatasource;
  final GetUserLocalDatasource _getUserLocalDatasource;

  UserLocalRepositoryImp(
    this._saveLoginLocalDatasource,
    this._getUserLocalDatasource,
  );

  @override
  Future<Either<SaveLoginLocalErrors, bool>> saveLoginLocal(
    String userID,
    String user,
    String password,
  ) async {
    try {
      final passTo64 = base64Encode(password.codeUnits);
      final result = await _saveLoginLocalDatasource(userID, user, passTo64);
      return right(result);
    } on UnableToSaveLoginLocal catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<GetUserLocalErrors, UserLocalEntity>> getUserLocal() async {
    try {
      final result = await _getUserLocalDatasource();

      return right(UserLocalDto.fromMap(jsonDecode(result)));
    } on LocalUserNotFound catch (e) {
      return left(e);
    }
  }
}
