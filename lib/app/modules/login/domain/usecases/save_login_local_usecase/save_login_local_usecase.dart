import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';

abstract class SaveLoginLocalUsecase {
  Future<Either<SaveLoginLocalErrors, bool>> call(
    String userID,
    String user,
    String password,
  );
}
