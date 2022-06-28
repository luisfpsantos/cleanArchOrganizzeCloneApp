import 'package:organizze_app/app/core/modules/verify_user/domain/errors/verify_user_by_id_erros.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/repositories/verify_user_repository.dart';
import 'package:organizze_app/app/core/modules/verify_user/infra/datasources/verify_user_by_id_datasource.dart';

class VerifyUserRepositoryImp implements VerifyUserRepository {
  final VerifyUserByIdDatasource _verifyUserByIdDatasource;

  VerifyUserRepositoryImp(this._verifyUserByIdDatasource);

  @override
  Future<Either<VerifyUserByIdErrors, bool>> verify(String id) async {
    try {
      final result = await _verifyUserByIdDatasource(id);
      if (result['authenticated']) {
        return right(true);
      } else {
        return left(UserNotAuthenticated('User is not authenticated'));
      }
    } on UserNotFound catch (e) {
      return left(e);
    }
  }
}
