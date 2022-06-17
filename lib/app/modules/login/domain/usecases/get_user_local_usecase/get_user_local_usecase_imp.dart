import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';

class GetUserLocalUsecaseImp implements GetUserLocalUsecase {
  final GetUserLocalRepository _getUserLocalRepository;

  GetUserLocalUsecaseImp(this._getUserLocalRepository);

  @override
  Future<Either<GetUserLocalErrors, LoginEntity>> call() async {
    return await _getUserLocalRepository();
  }
}
