import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';

class SaveLoginLocalUsecaseImp implements SaveLoginLocalUsecase {
  final SaveLoginLocalRepository _saveLoginLocalRepository;

  SaveLoginLocalUsecaseImp(this._saveLoginLocalRepository);

  @override
  Future<Either<SaveLoginLocalErrors, bool>> call(LoginEntity login) async {
    return await _saveLoginLocalRepository(login);
  }
}
