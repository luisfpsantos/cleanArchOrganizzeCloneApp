import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';

abstract class GetListAccountRepository {
  Future<Either<GetListAccountErrors, List<AccountEntity>>> call();
}
