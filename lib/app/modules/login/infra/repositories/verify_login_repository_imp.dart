import 'package:organizze_app/app/modules/login/domain/errors/verify_login_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/verify_login_datasource.dart';

class VerifyLoginRepositoryImp implements VerifyLoginRepository {
  final VerifyLoginDatasource _verifyLoginDatasource;

  VerifyLoginRepositoryImp(this._verifyLoginDatasource);

  @override
  Future<Either<VerifyLoginErrors, bool>> call(
      String user, String password) async {
    try {
      final result = await _verifyLoginDatasource(user, password);
      return right(result);
    } on UserOrPasswordInvalid catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error'));
    }
  }
}
