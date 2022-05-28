import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_local_datasource.dart';

class GetUserLocalRepositoryImp implements GetUserLocalRepository {
  final GetUserLocalDatasource _getUserLocalDatasource;

  GetUserLocalRepositoryImp(this._getUserLocalDatasource);

  @override
  Either<GetUserLocalErrors, LoginEntity> call() {
    try {
      var result = _getUserLocalDatasource();
      return Right(result);
    } on LocalUserNotFound catch (e) {
      return Left(e);
    } catch (e) {
      return Left(RepositoryError('unknown error'));
    }
  }
}
