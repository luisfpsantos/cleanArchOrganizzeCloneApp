import 'package:organizze_app/app/core/modules/verify_user/domain/errors/verify_user_by_id_erros.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/repositories/verify_user_repository.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/usecases/verify_user_by_id_usecase/verify_user_by_id_usecase.dart';

class VerifyUserByIdUsecaseImp implements VerifyUserByIdUsecase {
  final VerifyUserRepository _verifyUserRepository;

  VerifyUserByIdUsecaseImp(this._verifyUserRepository);

  @override
  Future<Either<VerifyUserByIdErrors, bool>> call(String id) async {
    return await _verifyUserRepository.verify(id);
  }
}
