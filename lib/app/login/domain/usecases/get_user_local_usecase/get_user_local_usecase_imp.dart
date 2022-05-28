import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';

class GetUserLocalUsecaseImp implements GetUserLocalUsecase {
  final GetUserLocalRepository _getUserLocalRepository;

  GetUserLocalUsecaseImp(this._getUserLocalRepository);

  @override
  Either<GetUserLocalErrors, LoginEntity> call() {
    return _getUserLocalRepository();
  }
}
