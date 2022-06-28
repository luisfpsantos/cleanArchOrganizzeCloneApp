import 'package:organizze_app/app/modules/login/domain/entities/user_local_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';

class GetUserLocalUsecaseImp implements GetUserLocalUsecase {
  final UserLocalRepository _userLocalRepository;

  GetUserLocalUsecaseImp(this._userLocalRepository);

  @override
  Future<Either<GetUserLocalErrors, UserLocalEntity>> call() async {
    return await _userLocalRepository.getUserLocal();
  }
}
