import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';

class SaveLoginLocalRepositoryImp implements SaveLoginLocalRepository {
  final SaveLoginLocalDatasource _saveLoginLocalDatasource;

  SaveLoginLocalRepositoryImp(this._saveLoginLocalDatasource);

  @override
  Future<Either<SaveLoginLocalErrors, bool>> call(LoginEntity login) async {
    try {
      var result = await _saveLoginLocalDatasource(login);
      return right(result);
    } on UnableToSaveLoginLocal catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error'));
    }
  }
}
