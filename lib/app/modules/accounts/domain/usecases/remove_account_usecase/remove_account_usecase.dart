import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/remove_account_errors.dart';

abstract class RemoveAccountUsecase {
  Future<Either<RemoveAccountErrors, bool>> call(
    String userID,
    String accountID,
  );
}
