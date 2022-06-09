import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_local_datasource.dart';

class GetUserLocalRepositoryImp implements GetUserLocalRepository {
  final GetUserLocalDatasource _getUserLocalDatasource;

  GetUserLocalRepositoryImp(this._getUserLocalDatasource);

  @override
  Future<Either<GetUserLocalErrors, LoginEntity>> call() async {
    try {
      var result = await _getUserLocalDatasource();
      return right(result);
    } on LocalUserNotFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error'));
    }
  }
}
