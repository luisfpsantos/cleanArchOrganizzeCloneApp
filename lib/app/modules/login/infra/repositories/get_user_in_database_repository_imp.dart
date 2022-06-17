import 'package:organizze_app/app/modules/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/get_user_in_database_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_in_database_datasource.dart';

class GetUserInDatabaseRepositoryImp implements GetUserInDatabaseRepository {
  final GetUserInDatabaseDatasource _getUserInDatabaseDatasource;

  GetUserInDatabaseRepositoryImp(this._getUserInDatabaseDatasource);

  @override
  Future<Either<GetUserInDatabaseErrors, LoggedUserEntity>> call(
      String loggedUser) async {
    try {
      var result = await _getUserInDatabaseDatasource(loggedUser);

      if (!result.authenticated) {
        return left(UserNotAuthenticated('User not Authenticated'));
      }

      return right(result);
    } on UserNotFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error'));
    }
  }
}
