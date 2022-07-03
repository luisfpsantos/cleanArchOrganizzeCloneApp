import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';

abstract class EditAccountUsecase {
  Future<Either<EditAccountErrors, bool>> call(
    AccountEntity account,
    String userID,
  );
}
