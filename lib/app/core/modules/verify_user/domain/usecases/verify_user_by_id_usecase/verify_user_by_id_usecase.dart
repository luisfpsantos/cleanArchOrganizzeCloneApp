import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/errors/verify_user_by_id_erros.dart';

abstract class VerifyUserByIdUsecase {
  Future<Either<VerifyUserByIdErrors, bool>> call(String id);
}
