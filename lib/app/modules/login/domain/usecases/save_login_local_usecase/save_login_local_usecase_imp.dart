import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';

class SaveLoginLocalUsecaseImp implements SaveLoginLocalUsecase {
  final UserLocalRepository _localRepository;

  SaveLoginLocalUsecaseImp(this._localRepository);

  @override
  Future<Either<SaveLoginLocalErrors, bool>> call(
    String userID,
    String user,
    String password,
  ) async {
    return await _localRepository.saveLoginLocal(userID, user, password);
  }
}
