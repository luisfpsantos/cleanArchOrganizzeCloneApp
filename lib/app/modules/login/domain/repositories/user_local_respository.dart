import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_local_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';

abstract class UserLocalRepository {
  Future<Either<GetUserLocalErrors, UserLocalEntity>> getUserLocal();

  Future<Either<SaveLoginLocalErrors, bool>> saveLoginLocal(
    String userID,
    String user,
    String password,
  );
}
