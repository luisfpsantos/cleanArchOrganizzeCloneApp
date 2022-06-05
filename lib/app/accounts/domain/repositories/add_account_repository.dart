import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_account_error.dart';

abstract class AddAccountRepository {
  Future<Either<AddAccountError, bool>> call(
    AccountEntity account,
    String userId,
  );
}
