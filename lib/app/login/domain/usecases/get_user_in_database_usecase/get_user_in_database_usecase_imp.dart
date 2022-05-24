import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_in_database_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase.dart';

class GetUserInDatabaseUsecaseImp implements GetUserInDatabaseUsecase {
  final GetUserInDatabaseRepository _getUserInDatabaseRepository;

  GetUserInDatabaseUsecaseImp(this._getUserInDatabaseRepository);

  @override
  Future<Either<GetUserInDatabaseErrors, LoggedUserEntity>> call(
      String loggedUser) async {
    return await _getUserInDatabaseRepository(loggedUser);
  }
}
