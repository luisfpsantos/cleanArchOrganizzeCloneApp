import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_in_database_errors.dart';

abstract class GetUserInDatabaseUsecase {
  Future<Either<GetUserInDatabaseErrors, LoggedUserEntity>> call(
      String loggedUser);
}
